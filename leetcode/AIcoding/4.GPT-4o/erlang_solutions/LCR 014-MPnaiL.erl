-module(solution).
-export([permutations/1]).

permutations(S) ->
    List = string:to_list(S),
    lists:usort(permutate(List)).

permutate([]) -> [[]];
permutate(L) ->
    [H | T] = L,
    [H1 | T1] = lists:partition(fun(X) -> X =:= H end, L),
    lists:flatmap(fun(X) -> lists:map(fun(Y) -> [X | Y] end, permutate(T1)) end, H1).