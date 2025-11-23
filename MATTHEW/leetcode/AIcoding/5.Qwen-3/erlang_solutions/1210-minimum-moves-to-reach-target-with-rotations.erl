-module(minimum_moves_to_reach_target_with_rotations).
-export([min_moves_to_reach_target/2]).

min_moves_to_reach_target(Grid, Target) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {StartRow, StartCol} = {0, 0},
    {TargetRow, TargetCol} = Target,
    Visited = gb_sets:empty(),
    Queue = queue:from_list([{StartRow, StartCol, 0, 0}]),
    min_moves_to_reach_target(Grid, TargetRow, TargetCol, Rows, Cols, Visited, Queue).

min_moves_to_reach_target(_, TargetRow, TargetCol, _, _, Visited, Queue) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {R, C, Steps, Dir}}, NewQueue} ->
            if
                R == TargetRow andalso C == TargetCol -> Steps;
                true ->
                    NewVisited = gb_sets:add({R, C, Dir}, Visited),
                    Directions = [{-1, 0, 0}, {1, 0, 1}, {0, -1, 2}, {0, 1, 3}],
                    NewQueue1 = lists:foldl(fun({DR, DC, D}, Acc) ->
                        NR = R + DR,
                        NC = C + DC,
                        if
                            NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols andalso Grid!!NR!!NC == 0 andalso not gb_sets:is_member({NR, NC, D}, NewVisited) ->
                                queue:in({NR, NC, Steps + 1, D}, Acc);
                            true ->
                                Acc
                        end
                    end, NewQueue, Directions),
                    min_moves_to_reach_target(Grid, TargetRow, TargetCol, Rows, Cols, NewVisited, NewQueue1)
            end
    end.