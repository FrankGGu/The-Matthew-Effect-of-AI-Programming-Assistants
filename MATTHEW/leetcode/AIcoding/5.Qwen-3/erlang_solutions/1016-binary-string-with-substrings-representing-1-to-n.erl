-module(solution).
-export([is_substring_present/2]).

is_substring_present(S, N) ->
    Max = 1 bsl N,
    Set = lists:usort([list_to_integer(lists:sublist(S, I, J), 2) || I <- lists:seq(1, length(S)), J <- lists:seq(1, length(S) - I + 1)]),
    lists:all(fun(X) -> X >= 1 andalso X =< N end, Set).

substring_list(S) ->
    L = length(S),
    [lists:sublist(S, I, J) || I <- lists:seq(1, L), J <- lists:seq(1, L - I + 1)].