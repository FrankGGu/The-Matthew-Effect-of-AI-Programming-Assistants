-spec count_good(Goods :: [integer()], K :: integer()) -> integer().
count_good(Nums, K) ->
    count_good(Nums, K, 0, 0, 0, #{}).

count_good([], _, _, Left, Ans, _) ->
    Ans;
count_good([Num | Rest], K, Right, Left, Ans, Count) ->
    NewCount = maps:update_with(Num, fun(V) -> V + 1 end, 1, Count),
    NewRight = Right + 1,
    {NewLeft, NewAns, NewCount1} = shrink(Num, NewCount, Left, NewRight, Ans, K),
    count_good(Rest, K, NewRight, NewLeft, NewAns, NewCount1).

shrink(Num, Count, Left, Right, Ans, K) ->
    case maps:get(Num, Count) of
        V when V >= K ->
            case maps:size(Count) of
                Size when Size > 1 ->
                    shrink_loop(Count, Left, Right, Ans, K);
                _ ->
                    {Left, Ans, Count}
            end;
        _ ->
            {Left, Ans, Count}
    end.

shrink_loop(Count, Left, Right, Ans, K) ->
    case maps:size(Count) of
        Size when Size > 1 ->
            case maps:iterator(Count) of
                {Key, V, _} when V >= K ->
                    shrink_loop(maps:remove(Key, Count), Left + 1, Right, Ans + (Right - Left), K);
                _ ->
                    {Left, Ans, Count}
            end;
        _ ->
            {Left, Ans, Count}
    end.