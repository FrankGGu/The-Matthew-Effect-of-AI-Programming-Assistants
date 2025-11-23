-spec split_array(Nums :: [integer()], K :: integer()) -> integer().
split_array(Nums, K) ->
    Left = lists:max(Nums),
    Right = lists:sum(Nums),
    binary_search(Nums, K, Left, Right).

binary_search(Nums, K, Left, Right) when Left < Right ->
    Mid = Left + (Right - Left) div 2,
    case can_split(Nums, K, Mid) of
        true -> binary_search(Nums, K, Left, Mid);
        false -> binary_search(Nums, K, Mid + 1, Right)
    end;
binary_search(_, _, Left, _) ->
    Left.

can_split(Nums, K, Max) ->
    can_split(Nums, K, Max, 0, 1).

can_split([], _, _, Sum, Count) ->
    Count =< K;
can_split([H | T], K, Max, Sum, Count) ->
    NewSum = Sum + H,
    if
        NewSum > Max ->
            can_split(T, K, Max, H, Count + 1);
        true ->
            can_split(T, K, Max, NewSum, Count)
    end.