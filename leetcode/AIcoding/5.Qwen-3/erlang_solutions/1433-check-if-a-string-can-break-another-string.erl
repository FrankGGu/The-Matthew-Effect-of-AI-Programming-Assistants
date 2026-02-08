-module(solution).
-export([check_if_can_break/2]).

check_if_can_break(S1, S2) ->
    SortedS1 = lists:sort(S1),
    SortedS2 = lists:sort(S2),
    check(SortedS1, SortedS2).

check([], []) ->
    true;
check([H1 | T1], [H2 | T2]) ->
    if
        H1 >= H2 ->
            check(T1, T2);
        true ->
            false
    end.