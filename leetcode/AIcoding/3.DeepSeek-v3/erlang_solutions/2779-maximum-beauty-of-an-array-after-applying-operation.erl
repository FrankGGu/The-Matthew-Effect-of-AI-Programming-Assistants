-spec maximum_beauty(Nums :: [integer()], K :: integer()) -> integer().
maximum_beauty(Nums, K) ->
    Sorted = lists:sort(Nums),
    maximum_beauty(Sorted, K, 0, 0, 0).

maximum_beauty([], _K, _Left, _Right, Max) -> Max;
maximum_beauty([H | T], K, Left, Right, Max) ->
    NewRight = Right + 1,
    case H - lists:nth(Left + 1, [H | T]) =< 2 * K of
        true ->
            maximum_beauty(T, K, Left, NewRight, max(Max, NewRight - Left));
        false ->
            maximum_beauty(T, K, Left + 1, NewRight, Max)
    end.