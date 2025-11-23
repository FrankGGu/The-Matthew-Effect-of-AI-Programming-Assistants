-module(solution).
-export([can_move/2]).

can_move(Start, Target) ->
    {StartList, TargetList} = {string:to_list(Start), string:to_list(Target)},
    case lists:sort(StartList) == lists:sort(TargetList) of
        true -> can_move_helper(StartList, TargetList);
        false -> false
    end.

can_move_helper([], []) ->
    true;
can_move_helper([H1 | T1], [H2 | T2]) ->
    case H1 == H2 of
        true -> can_move_helper(T1, T2);
        false -> can_move_helper(T1, [H2 | T2])
    end.