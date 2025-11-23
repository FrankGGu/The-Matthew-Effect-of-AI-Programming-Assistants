-module(most_popular_video_creator).
-export([most_popular_video_creator/3]).

most_popular_video_creator(Creators, Ids, Views) ->
    Len = length(Creators),
    {CreatorViews, _} = lists:foldl(
        fun(I, {Acc, Index}) ->
            Creator = lists:nth(Index + 1, Creators),
            View = lists:nth(Index + 1, Views),
            case maps:is_key(Creator, Acc) of
                true ->
                    Acc1 = maps:update(Creator, maps:get(Creator, Acc) + View, Acc);
                false ->
                    Acc1 = maps:put(Creator, View, Acc)
            end,
            {Acc1, Index + 1}
        end,
        {#{}, 0},
        lists:seq(1, Len)
    ),
    MaxView = lists:max(maps:values(CreatorViews)),
    TopCreators = [Creator || Creator <- maps:keys(CreatorViews), maps:get(Creator, CreatorViews) == MaxView],

    {CreatorIdViews, _} = lists:foldl(
        fun(I, {Acc, Index}) ->
            Creator = lists:nth(Index + 1, Creators),
            Id = lists:nth(Index + 1, Ids),
            View = lists:nth(Index + 1, Views),
            case lists:member(Creator, TopCreators) of
                true ->
                    case maps:is_key(Creator, Acc) of
                        true ->
                            IdViews = maps:get(Creator, Acc),
                            case View > element(1, IdViews) of
                                true ->
                                    Acc1 = maps:update(Creator, {Id, View}, Acc);
                                false ->
                                    case View == element(1, IdViews) of
                                        true ->
                                            ExistingId = element(0, IdViews),
                                            case Id < ExistingId of
                                                true ->
                                                    Acc1 = maps:update(Creator, {Id, View}, Acc);
                                                false ->
                                                    Acc1 = Acc
                                            end;
                                        false ->
                                            Acc1 = Acc
                                    end
                            end;
                        false ->
                            Acc1 = maps:put(Creator, {Id, View}, Acc)
                    end;
                false ->
                    Acc1 = Acc
            end,
            {Acc1, Index + 1}
        end,
        {#{}, 0},
        lists:seq(1, Len)
    ),

    [element(0, maps:get(Creator, CreatorIdViews)) || Creator <- TopCreators].