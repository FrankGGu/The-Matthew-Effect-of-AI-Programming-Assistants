-spec most_popular_creator(Creators :: [unicode:unicode_binary()], Ids :: [unicode:unicode_binary()], Views :: [integer()]) -> [[unicode:unicode_binary()]].
most_popular_creator(Creators, Ids, Views) ->
    {TotalViews, VideoMap} = lists:foldl(
        fun({Creator, Id, View}, {AccViews, AccMap}) ->
            NewAccViews = maps:update_with(Creator, fun(V) -> V + View end, View, AccViews),
            NewAccMap = maps:update_with(Creator, fun(Videos) -> 
                case Videos of
                    [{MaxView, _} | _] when View > MaxView -> [{View, [Id]}];
                    [{MaxView, L} | _] when View == MaxView -> [{MaxView, [Id | L]}];
                    _ -> Videos ++ [{View, [Id]}]
                end
            end, [{View, [Id]}], AccMap),
            {NewAccViews, NewAccMap}
        end,
        {maps:new(), maps:new()},
        lists:zip3(Creators, Ids, Views)
    ),
    MaxTotal = case maps:values(TotalViews) of
        [] -> 0;
        Vs -> lists:max(Vs)
    end,
    MaxCreators = [Creator || {Creator, V} <- maps:to_list(TotalViews), V == MaxTotal],
    lists:sort(
        lists:flatmap(
            fun(Creator) ->
                [{MaxView, IdsList}] = maps:get(Creator, VideoMap),
                SortedIds = lists:sort(IdsList),
                [[Creator, Id] || Id <- SortedIds]
            end,
            MaxCreators
        )
    ).