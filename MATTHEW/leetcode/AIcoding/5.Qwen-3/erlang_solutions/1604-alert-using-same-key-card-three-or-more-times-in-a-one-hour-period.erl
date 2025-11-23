-module(solution).
-export([alertAfterThreeEvents/1]).

alertAfterThreeEvents(Events) ->
    Sorted = lists:sort(Events),
    alertAfterThreeEvents(Sorted, 0, 0, []).

alertAfterThreeEvents([], _, _, _) -> false;
alertAfterThreeEvents([H | T], Index, Count, [Last1, Last2 | _] = Prev) when Index >= 2 ->
    Time = element(2, H),
    if
        Time - Last1 < 60 -> true;
        true -> alertAfterThreeEvents(T, Index + 1, 0, [Time | lists:tl(Prev)])
    end;
alertAfterThreeEvents([H | T], Index, Count, Prev) ->
    Time = element(2, H),
    alertAfterThreeEvents(T, Index + 1, Count + 1, [Time | Prev]).