-module(solution).
-export([min_operations/2]).

min_operations(Array, k) ->
    N = length(Array),
    Groups = [lists:sublist(Array, I + 1, k) || I <- lists:seq(0, k - 1)],
    lists:sum([length(Group) - length(lis:longest_increasing_subsequence(Group)) || Group <- Groups]).

lis:longest_increasing_subsequence([]) -> [];
lis:longest_increasing_subsequence(List) ->
    Sorted = lists:sort(List),
    lists:foldl(fun(X, Acc) -> [X | Acc] end, [], Sorted).