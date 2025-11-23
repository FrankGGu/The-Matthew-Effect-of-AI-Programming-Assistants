-module(solution).
-export([checkIfCanBreak/2]).

checkIfCanBreak(S1, S2) ->
    SortedS1 = lists:sort(S1),
    SortedS2 = lists:sort(S2),
    can_break(SortedS1, SortedS2) orelse can_break(SortedS2, SortedS1).

can_break([], []) -> true;
can_break([H1|T1], [H2|T2]) when H1 >= H2 ->
    can_break(T1, T2);
can_break(_, _) -> false.