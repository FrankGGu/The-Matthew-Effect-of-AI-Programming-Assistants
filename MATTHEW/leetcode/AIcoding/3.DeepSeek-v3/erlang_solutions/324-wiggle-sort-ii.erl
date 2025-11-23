-spec wiggle_sort(Nums :: [integer()]) -> [integer()].
wiggle_sort(Nums) ->
    Sorted = lists:sort(fun(A, B) -> A >= B end, Nums),
    Len = length(Sorted),
    Mid = (Len + 1) div 2,
    {Left, Right} = lists:split(Mid, Sorted),
    wiggle_merge(Left, Right, []).

wiggle_merge([], [], Acc) ->
    lists:reverse(Acc);
wiggle_merge([L|Left], [R|Right], Acc) ->
    wiggle_merge(Left, Right, [R, L | Acc]);
wiggle_merge([L|Left], [], Acc) ->
    wiggle_merge(Left, [], [L | Acc]).