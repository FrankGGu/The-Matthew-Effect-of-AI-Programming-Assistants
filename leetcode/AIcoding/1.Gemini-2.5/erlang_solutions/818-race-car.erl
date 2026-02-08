-module(solution).
-export([racecar/1]).

racecar(Target) ->
    Q = queue:in({{0, 1}, 0}, queue:new()),
    Visited = sets:add_element({0, 1}, sets:new()),
    bfs(Q, Visited, Target).

bfs(Q, Visited, Target) ->
    case queue:out(Q) of
        {{value, {{Pos, Speed}, Steps}}, RestQ} ->
            if Pos == Target ->
                Steps;
            true ->
                NewPosA = Pos + Speed,
                NewSpeedA = Speed * 2,
                NewStepsA = Steps + 1,
                StateA = {NewPosA, NewSpeedA},

                {NextQ1, NextVisited1} =
                    if NewPosA >= 0 and NewPosA <= 2 * Target and not sets:is_element(StateA, Visited) ->
                        {queue:in({StateA, NewStepsA}, RestQ), sets:add_element(StateA, Visited)};
                    true ->
                        {RestQ, Visited}
                    end,

                NewPosR = Pos,
                NewSpeedR = if Speed > 0 -> -1; true -> 1 end,
                NewStepsR = Steps + 1,
                StateR = {NewPosR, NewSpeedR},

                {NextQ2, NextVisited2} =
                    if NewPosR >= 0 and NewPosR <= 2 * Target and not sets:is_element(StateR, NextVisited1) ->
                        {queue:in({StateR, NewStepsR}, NextQ1), sets:add_element(StateR, NextVisited1)};
                    true ->
                        {NextQ1, NextVisited1}
                    end,

                bfs(NextQ2, NextVisited2, Target)
            end;
        {empty, _} ->
            -1
    end.