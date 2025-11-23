-module(solution).
-export([solve/1]).

solve(S) ->
    check_pairs(S).

check_pairs([_]) -> false;
check_pairs([]) -> false;
check_pairs([H1, H2 | T]) ->
    if
        H1 == H2 -> true;
        true -> check_pairs([H2 | T])
    end.