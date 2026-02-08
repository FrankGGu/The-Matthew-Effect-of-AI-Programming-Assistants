-module(solution).
-export([special_array/1]).

special_array(Nums) ->
    Max = lists:max(Nums),
    special_array_helper(Nums, Max, 0).

special_array_helper(_, -1, _) -> -1;
special_array_helper(Nums, X, Count) ->
    GreaterCount = lists:length(lists:filter(fun(N) -> N >= X end, Nums)),
    case GreaterCount of
        X -> X;
        _ when GreaterCount > X -> special_array_helper(Nums, X - 1, Count);
        _ -> special_array_helper(Nums, X - 1, Count)
    end.