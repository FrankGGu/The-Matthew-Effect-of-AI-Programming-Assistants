-module(solution).
-export([check_if_can_break/2]).

check_if_can_break(S1, S2) ->
    Sorted1 = lists:sort(string:to_list(S1)),
    Sorted2 = lists:sort(string:to_list(S2)),
    can_break(Sorted1, Sorted2) orelse can_break(Sorted2, Sorted1).

can_break([], _) -> true;
can_break([H1 | T1], L2) ->
    case lists:filter(fun(X) -> X < H1 end, L2) of
        [] -> true;
        _ -> can_break(T1, L2)
    end.