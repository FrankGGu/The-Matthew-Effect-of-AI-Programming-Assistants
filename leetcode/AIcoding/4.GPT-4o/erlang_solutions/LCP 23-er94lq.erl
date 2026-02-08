-module(solution).
-export([get_permutation/1]).

get_permutation(N) ->
    List = lists:seq(1, N),
    Perm = magic_permutation(List, 0, N),
    Perm.

magic_permutation(List, Index, N) when Index < N ->
    {H, T} = lists:split(Index, List),
    {H1, T1} = lists:split(1, T),
    [H | magic_permutation(H1 ++ T1, Index + 1, N)];
magic_permutation(_, _, _) -> [].