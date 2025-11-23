-module(solution).
-export([execute_instructions/2]).

execute_instructions(_, _) ->
    false.

execute_instructions(Instructions, start_pos) ->
    execute_instructions(Instructions, start_pos, 0).

execute_instructions([], {X, Y}, _) ->
    X >= 0 andalso Y >= 0 andalso X < 3 andalso Y < 3;

execute_instructions([H | T], {X, Y}, I) ->
    case H of
        0 -> execute_instructions(T, {X, Y + 1}, I + 1);
        1 -> execute_instructions(T, {X + 1, Y}, I + 1);
        2 -> execute_instructions(T, {X, Y - 1}, I + 1);
        3 -> execute_instructions(T, {X - 1, Y}, I + 1)
    end.