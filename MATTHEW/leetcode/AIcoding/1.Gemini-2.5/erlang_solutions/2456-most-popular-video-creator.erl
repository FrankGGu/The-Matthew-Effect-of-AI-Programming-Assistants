-module(solution).
-export([most_popular_video_creator/3]).

most_popular_video_creator(Creators, VideoIds, Views) ->
    {CreatorTotalViewsMap, CreatorVideosMap} = aggregate_data(lists:zip3(Creators, VideoIds, Views)),
    MaxTotalViews = find_max_total_views(CreatorTotalViewsMap),
    filter_and_format_results(CreatorTotalViewsMap, CreatorVideosMap, MaxTotalViews).

aggregate_data(Triples) ->
    aggregate_data(Triples, #{}, #{}).

aggregate_data([], CreatorTotalViewsMap, CreatorVideosMap) ->
    {CreatorTotalViewsMap, CreatorVideosMap};
aggregate_data([{Creator, VideoId, View} | Rest], CreatorTotalViewsMap, CreatorVideosMap) ->
    NewCreatorTotalViewsMap = maps:update_with(Creator, fun(CurrentViews) -> CurrentViews + View end, View, CreatorTotalViewsMap),
    NewCreatorVideosMap = maps:update_with(Creator, fun(Videos) -> [{VideoId, View} | Videos] end, [{VideoId, View}], CreatorVideosMap),
    aggregate_data(Rest, NewCreatorTotalViewsMap, NewCreatorVideosMap).

find_max_total_views(CreatorTotalViewsMap) ->
    lists:foldl(fun({_Creator, TotalView}, Max) -> max(TotalView, Max) end, 0, maps:to_list(CreatorTotalViewsMap)).

filter_and_format_results(CreatorTotalViewsMap, CreatorVideosMap, MaxTotalViews) ->
    lists:foldl(fun({Creator, TotalViews}, Acc) ->
        if
            TotalViews == MaxTotalViews ->
                Videos = maps:get(Creator, CreatorVideosMap),
                MostPopularVideoId = find_most_popular_video_for_creator(Videos),
                [[Creator, MostPopularVideoId] | Acc];
            true ->
                Acc
        end
    end, [], maps:to_list(CreatorTotalViewsMap)).

find_most_popular_video_for_creator(Videos) ->
    [{FirstVideoId, FirstViews} | RestVideos] = Videos,
    find_most_popular_video_for_creator_recursive(RestVideos, FirstVideoId, FirstViews).

find_most_popular_video_for_creator_recursive([], CurrentBestVideoId, _CurrentBestViews) ->
    CurrentBestVideoId;
find_most_popular_video_for_creator_recursive([{VideoId, View} | Rest], CurrentBestVideoId, CurrentBestViews) ->
    if
        View > CurrentBestViews ->
            find_most_popular_video_for_creator_recursive(Rest, VideoId, View);
        View == CurrentBestViews ->
            if
                VideoId < CurrentBestVideoId ->
                    find_most_popular_video_for_creator_recursive(Rest, VideoId, View);
                true ->
                    find_most_popular_video_for_creator_recursive(Rest, CurrentBestVideoId, CurrentBestViews)
            end;
        true ->
            find_most_popular_video_for_creator_recursive(Rest, CurrentBestVideoId, CurrentBestViews)
    end.