-module(solution).
-export([min_cost_array_permutation/1]).

min_cost_array_permutation(Arr) ->
    N = length(Arr),
    Cost = fun(I, J) -> abs(lists:nth(I+1, Arr) - lists:nth(J+1, Arr)) end,
    Perms = permutations(lists:seq(0, N-1)),
    lists:min([lists:foldl(fun({I, J}, Acc) -> Acc + Cost(I, J) end, 0, lists:zip(Perms, lists:seq(0, N-1))) || _ <- Perms]).

permutations([]) -> [[]];
permutations(L) -> 
    [[H | T] || H <- L, T <- permutations(lists:delete(H, L))].