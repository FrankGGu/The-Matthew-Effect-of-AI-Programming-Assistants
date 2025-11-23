-module(solution).
-export([minimumMoves/1]).

is_valid(R, C, N, Grid) when R >= 0, R < N, C >= 0, C < N ->
    lists:nth(C + 1, lists:nth(R + 1, Grid)) == 0;
is_valid(_R, _C, _N, _Grid) ->
    false.

minimumMoves(Grid) ->
    N = length(Grid),

    %% Queue stores {Row, Col, Orientation, Moves}
    %% (R, C) is the position of the snake's tail.
    Q = queue:in({0, 0, 0, 0}, queue:new()),

    %% Visited set stores {Row, Col, Orientation}
    Visited = gb_sets:add({0, 0, 0}, gb_sets:new()),

    bfs(Q, Visited, N, Grid).

bfs(Q, Visited, N, Grid) ->
    case queue:out(Q) of
        {{value, {R, C, Orientation, Moves}}, RestQ} ->
            %% Check if target is reached
            %% Target: tail at {N-1, N-2}, horizontal (0) orientation
            %% Head will be at {N-1, N-1}
            if
                R == N - 1 andalso C == N - 2 andalso Orientation == 0 ->
                    Moves;
                true ->
                    NextMoves = Moves + 1,
                    AllNewStates = [],

                    %% Move Right
                    %% Horizontal: Current tail (R, C), head (R, C+1). New tail (R, C+1), head (R, C+2). Requires (R, C+2) empty.
                    %% Vertical: Current tail (R, C), head (R+1, C). New tail (R, C+1), head (R+1, C+1). Requires (R, C+1) and (R+1, C+1) empty.
                    NewStatesRight = 
                        case Orientation of
                            0 when is_valid(R, C + 2, N, Grid) ->
                                [{R, C + 1, 0}];
                            1 when is_valid(R, C + 1, N, Grid) andalso is_valid(R + 1, C + 1, N, Grid) ->
                                [{R, C + 1, 1}];
                            _ ->
                                []
                        end,

                    %% Move Down
                    %% Horizontal: Current tail (R, C), head (R, C+1). New tail (R+1, C), head (R+1, C+1). Requires (R+1, C) and (R+1, C+1) empty.
                    %% Vertical: Current tail (R, C), head (R+1, C). New tail (R+1, C), head (R+2, C). Requires (R+2, C) empty.
                    NewStatesDown = 
                        case Orientation of
                            0 when is_valid(R + 1, C, N, Grid) andalso is_valid(R + 1, C + 1, N, Grid) ->
                                [{R + 1, C, 0}];
                            1 when is_valid(R + 2, C, N, Grid) ->
                                [{R + 1, C, 1}];
                            _ ->
                                []
                        end,

                    %% Rotate Clockwise (horizontal to vertical)
                    %% Current: tail (R, C), head (R, C+1).
                    %% New: tail (R, C), head (R+1, C).
                    %% Requires (R+1, C) and (R+1, C+1) to be empty.
                    NewStatesRotateCW = 
                        case Orientation of
                            0 when is_valid(R + 1, C, N, Grid) andalso is_valid(R + 1, C + 1, N, Grid) ->
                                [{R, C, 1}]; %% New orientation is vertical
                            _ ->
                                []
                        end,

                    %% Rotate Counter-Clockwise (vertical to horizontal)
                    %% Current: tail (R, C), head (R+1, C).
                    %% New: tail (R, C), head (R, C+1).
                    %% Requires (R, C+1) and (R+1, C+1) to be empty.
                    NewStatesRotateCCW = 
                        case Orientation of
                            1 when is_valid(R, C + 1, N, Grid) andalso is_valid(R + 1, C + 1, N, Grid) ->
                                [{R, C, 0}]; %% New orientation is horizontal
                            _ ->
                                []
                        end,

                    AllNewStates = NewStatesRight ++ NewStatesDown ++ NewStatesRotateCW ++ NewStatesRotateCCW,

                    {NewQ, NewVisited} = lists:foldl(
                        fun({NextR, NextC, NextOrientation}, {AccQ, AccVisited}) ->
                            case gb_sets:is_member({NextR, NextC, NextOrientation}, AccVisited) of
                                true ->
                                    {AccQ, AccVisited};
                                false ->
                                    {queue:in({NextR, NextC, NextOrientation, NextMoves}, AccQ),
                                     gb_sets:add({NextR, NextC, NextOrientation}, AccVisited)}
                            end
                        end,
                        {RestQ, Visited},
                        AllNewStates
                    ),
                    bfs(NewQ, NewVisited, N, Grid)
            end;
        {empty, _} ->
            %% No path found
            -1
    end.