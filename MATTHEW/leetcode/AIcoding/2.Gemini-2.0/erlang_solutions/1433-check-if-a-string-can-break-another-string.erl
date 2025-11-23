-module(check_break).
-export([can_break/2]).

can_break(S1, S2) ->
    L1 = string:to_lower(S1),
    L2 = string:to_lower(S2),
    Sorted1 = lists:sort(string:to_list(L1)),
    Sorted2 = lists:sort(string:to_list(L2)),
    can_break_helper(Sorted1, Sorted2) orelse can_break_helper(Sorted2, Sorted1).

can_break_helper([], []) ->
    true;
can_break_helper([H1|T1], [H2|T2]) ->
    if
        H1 >= H2 ->
            can_break_helper(T1, T2);
        true ->
            false
    end.