-module(open_the_lock).
-export([open_lock/1]).

open_lock(Deadends) ->
    open_lock(Deadends, 0, 0, 0, 0, sets:new()).

open_lock(Deadends, A, B, C, D, Visited) ->
    Case = [A, B, C, D],
    case lists:member(Case, Deadends) of
        true -> -1;
        false ->
            case Case of
                [0,0,0,0] -> 0;
                _ ->
                    case sets:is_element(Case, Visited) of
                        true -> -1;
                        false ->
                            NewVisited = sets:add_element(Case, Visited),
                            NextSteps = generate_next_steps(A, B, C, D),
                            Results = lists:map(fun(Step) -> open_lock(Deadends, Step, NewVisited) end, NextSteps),
                            ValidResults = lists:filter(fun(R) -> R /= -1 end, Results),
                            case ValidResults of
                                [] -> -1;
                                _ -> lists:min(ValidResults) + 1
                            end
                    end
            end
    end.

open_lock(Deadends, [A,B,C,D], Visited) ->
    open_lock(Deadends, A, B, C, D, Visited).

generate_next_steps(A, B, C, D) ->
    Steps = [
        [A+1, B, C, D],
        [A-1, B, C, D],
        [A, B+1, C, D],
        [A, B-1, C, D],
        [A, B, C+1, D],
        [A, B, C-1, D],
        [A, B, C, D+1],
        [A, B, C, D-1]
    ],
    lists:map(fun([X,Y,Z,W]) ->
        X1 = if X < 0 -> 9; X > 9 -> 0; true -> X end,
        Y1 = if Y < 0 -> 9; Y > 9 -> 0; true -> Y end,
        Z1 = if Z < 0 -> 9; Z > 9 -> 0; true -> Z end,
        W1 = if W < 0 -> 9; W > 9 -> 0; true -> W end,
        [X1, Y1, Z1, W1]
    end, Steps).