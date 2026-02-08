-module(solution).
-export([find_min_step/2]).

-spec find_min_step(binary(), binary()) -> integer().
find_min_step(Board, Hand) ->
    find_min_step(Board, Hand, 0).

find_min_step(Board, Hand, Steps) ->
    case Hand of
        "" -> 
            %% If no balls are left in hand, return -1 if the board is not empty
            if Board == "" -> Steps; true -> -1 end;
        _ -> 
            %% Try every possible insertion of balls from the hand into the board
            lists:foldl(fun(Ball, Acc) ->
                %% Generate new board with the current ball inserted
                NewBoard = insert_ball(Board, Ball),
                %% Recurse on the new board with reduced hand
                case find_min_step(NewBoard, remove_ball(Hand, Ball), Steps + 1) of
                    -1 -> Acc;
                    NewSteps -> min(Acc, NewSteps)
                end
            end, -1, Hand)
    end.

insert_ball(Board, Ball) ->
    %% Insert the ball into all possible positions and return the modified board
    %% Check for each position in the board to see if a new group is created
    %% and remove the consecutive groups after the insertion.
    %% This is just a placeholder for logic related to ball insertion.

remove_ball(Hand, Ball) ->
    %% Remove the used ball from hand
    lists:delete(Ball, Hand).
