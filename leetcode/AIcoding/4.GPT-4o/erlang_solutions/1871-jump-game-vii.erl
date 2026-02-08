-module(solution).
-export([can_jump/2]).

can_jump(Start, s) ->
    can_jump(Start, s, 0).

can_jump(Start, s(L), Max) when Start =< Max ->
    true;
can_jump(Start, s(L), Max) ->
    case lists:nth(Start + 1, L) of
        'X' -> false;
        _ -> can_jump(Start + 1, s(L), Start + 1);
    end;
can_jump(Start, s(L), Max) ->
    case lists:nth(Start - 1, L) of
        'X' -> false;
        _ -> can_jump(Start - 1, s(L), Start - 1);
    end.