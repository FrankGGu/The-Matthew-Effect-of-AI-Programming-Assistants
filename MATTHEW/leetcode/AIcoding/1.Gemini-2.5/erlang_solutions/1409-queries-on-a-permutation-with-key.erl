-module(solution).
-export([queries_on_permutation_with_key/2]).

queries_on_permutation_with_key(Queries, M) ->
    InitialPermutation = lists:seq(1, M),
    solve(Queries, InitialPermutation, []).

solve([], _Permutation, Results) ->
    lists:reverse(Results);
solve([Query|RestQueries], Permutation, AccResults) ->
    {Index, PermutationWithoutQuery} = find_and_remove(Query, Permutation, 0),
    NewPermutation = [Query | PermutationWithoutQuery],
    solve(RestQueries, NewPermutation, [Index | AccResults]).

find_and_remove(Target, [Target|T], AccIndex) ->
    {AccIndex, T};
find_and_remove(Target, [H|T], AccIndex) ->
    {Index, RemainingList} = find_and_remove(Target, T, AccIndex + 1),
    {Index, [H|RemainingList]}.