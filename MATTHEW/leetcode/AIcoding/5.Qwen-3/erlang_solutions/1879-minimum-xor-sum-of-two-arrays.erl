-module(min_xor_sum).
-export([minimum_xor_sum/1]).

minimum_xor_sum(Nums) ->
    N = length(Nums),
    List = lists:seq(0, N - 1),
    Perms = permutations(List),
    lists:min([xor_sum(Nums, Perm) || Perm <- Perms]).

permutations([]) -> [[]];
permutations(L) ->
    [[H | T] || H <- L, T <- permutations(lists:delete(H, L))].

xor_sum(_, []) -> 0;
xor_sum(Nums, [H | T]) ->
    Num = lists:nth(H + 1, Nums),
    Num bxor xor_sum(Nums, T).