-module(solution).
-export([areAlmostEqual/2]).

areAlmostEqual(S, T) ->
    S == T orelse (length(S) == length(T) andalso same_chars(S, T)).

same_chars([], []) -> true;
same_chars([H1|T1], [H2|T2]) ->
    if H1 == H2 -> same_chars(T1, T2);
       true -> H1 == H2 andalso same_chars(T1, T2)
    end.