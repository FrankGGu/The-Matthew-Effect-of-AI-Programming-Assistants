-spec min_operations(Target :: [integer()], Arr :: [integer()]) -> integer().
min_operations(Target, Arr) ->
    IndexMap = maps:from_list([{X, I} || {I, X} <- lists:zip(lists:seq(0, length(Target) - 1), Target)]),
    Nums = [X || X <- Arr, maps:is_key(X, IndexMap)],
    LIS = [],
    Ans = lis(Nums, IndexMap, LIS),
    length(Target) - Ans.

lis([], _, LIS) -> length(LIS);
lis([H | T], IndexMap, LIS) ->
    Pos = binary_search(LIS, maps:get(H, IndexMap)),
    NewLIS = case Pos of
        -1 -> [maps:get(H, IndexMap) | LIS];
        _ -> lists:sublist(LIS, Pos) ++ [maps:get(H, IndexMap)] ++ lists:nthtail(Pos + 1, LIS)
    end,
    lis(T, IndexMap, NewLIS).

binary_search([], _) -> -1;
binary_search(List, Val) ->
    binary_search(List, Val, 0, length(List) - 1).

binary_search(List, Val, Low, High) when Low =< High ->
    Mid = (Low + High) div 2,
    case lists:nth(Mid + 1, List) of
        X when X < Val -> binary_search(List, Val, Mid + 1, High);
        _ -> binary_search(List, Val, Low, Mid - 1)
    end;
binary_search(_, _, Low, _) -> Low.