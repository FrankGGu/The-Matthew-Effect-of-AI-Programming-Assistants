-module(min_obstacle_removal).
-export([minimumObstacles/1]).

minimumObstacles(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {_, _, Result} = bfs({0, 0}, Grid, Rows, Cols, 0, #{}),
    Result.

bfs({R, C}, Grid, Rows, Cols, Steps, Visited) ->
    case {R, C} of
        {Rows-1, Cols-1} -> {Steps, {R, C}, Steps};
        _ ->
            Next = [
                {R+1, C},
                {R-1, C},
                {R, C+1},
                {R, C-1}
            ],
            Valid = lists:filter(
                fun({NR, NC}) ->
                    NR >= 0 andalso NR < Rows andalso NC >= 0 andalso NC < Cols
                end,
                Next
            ),
            NewVisited = maps:put({R, C}, Steps, Visited),
            Sorted = lists:sort(
                fun({A, B}, {C, D}) ->
                    maps:get({A, B}, NewVisited, infinity) =< maps:get({C, D}, NewVisited, infinity)
                end,
                Valid
            ),
            lists:foldl(
                fun({NR, NC}, {MinSteps, Pos, Acc}) ->
                    Cost = if element(NR+1, Grid) == 1 -> 1; true -> 0 end,
                    NewSteps = Steps + Cost,
                    case maps:is_key({NR, NC}, NewVisited) of
                        true ->
                            Existing = maps:get({NR, NC}, NewVisited),
                            if NewSteps < Existing -> {NewSteps, {NR, NC}, NewSteps};
                               true -> {MinSteps, Pos, Acc}
                            end;
                        false ->
                            {NewSteps, {NR, NC}, NewSteps}
                    end
                end,
                {infinity, {0, 0}, infinity},
                Sorted
            )
    end.