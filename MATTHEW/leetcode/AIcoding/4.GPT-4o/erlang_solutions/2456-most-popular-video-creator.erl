-module(solution).
-export([mostPopularCreator/2]).

mostPopularCreator(VideoList, Limit) ->
    VideoMap = maps:from_list([{VideoName, {Creator, Views}} || {Creator, VideoName, Views} <- VideoList]),
    CreatorViews = lists:foldl(fun({Creator, {VideoName, Views}}, Acc) ->
        case maps:find(Creator, Acc) of
            {ok, {TotalViews, Videos}} ->
                maps:update(Creator, {TotalViews + Views, [VideoName | Videos]}, Acc);
            _ ->
                maps:put(Creator, {Views, [VideoName]}, Acc)
        end
    end, #{}, VideoMap),
    PopularCreators = maps:to_list(CreatorViews),
    SortedCreators = lists:sort(fun({_, {V1, _}}, {_, {V2, _}}) -> V1 > V2 end, PopularCreators),
    MaxViews = case SortedCreators of
        [] -> 0;
        [{_, {Max, _}} | _] -> Max
    end,
    Result = lists:foldl(fun({Creator, {Views, Videos}}, Acc) ->
        if Views == MaxViews -> 
            [{Creator, lists:max(Videos)} | Acc];
        true -> 
            Acc
        end
    end, [], SortedCreators),
    lists:reverse(Result).