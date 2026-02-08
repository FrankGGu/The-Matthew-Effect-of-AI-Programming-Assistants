-module(solution).
-export([min_cost/1]).

min_cost(A) ->
    N = length(A),
    Perms = permutations(A),
    {MinCost, _} = lists:foldl(fun(P, {CurrentMin, CurrentPerm}) ->
        Cost = calculate_cost(P, 0),
        if
            Cost < CurrentMin -> {Cost, P};
            true -> {CurrentMin, CurrentPerm}
        end
    end, {infinity, []}, Perms),
    MinCost.

permutations([]) -> [[]];
permutations(L) -> [[H|T] || H <- L, T <- permutations(L -- [H])].

calculate_cost([], _) -> 0;
calculate_cost([H|T], Prev) ->
    abs(H - Prev) + calculate_cost(T, H).