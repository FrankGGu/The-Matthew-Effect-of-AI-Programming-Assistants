-module(solution).
-export([hasValidPath/1]).

hasValidPath(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    StreetConnections = #{
        1 => [{0, -1}, {0, 1}],  % Left, Right
        2 => [{-1, 0}, {1, 0}],  % Up, Down
        3 => [{0, -1}, {1, 0}],  % Left, Down
        4 => [{0, 1}, {1, 0}],   % Right, Down
        5 => [{0, -1}, {-1, 0}], % Left, Up
        6 => [{0, 1}, {-1, 0}]   % Right, Up
    },

    OppositeDirections = #{
        {-1, 0} => {1, 0},   % Up -> Down
        {1, 0} => {-1, 0},   % Down -> Up
        {0, -1} => {0, 1},   % Left -> Right
        {0, 1} => {0, -1}    % Right -> Left
    },

    Queue = queue:from_list([{0, 0}]),
    Visited = sets:add({0, 0}, sets:new()),

    bfs(Queue, Visited, Grid, M, N, StreetConnections, OppositeDirections).

bfs(Queue, Visited, Grid, M, N, StreetConnections, OppositeDirections) ->
    case queue:out(Queue) of
        {{value, {R, C}}, CurrentQueue} ->
            if
                R == M - 1 andalso C == N - 1 ->
                    true;
                true ->
                    CurrentStreetType = lists:nth(C + 1, lists:nth(R + 1, Grid)),
                    AllowedDirs = maps:get(CurrentStreetType, StreetConnections),

                    {NextQueue, NextVisited} = lists:foldl(
                        fun({DR, DC}, {AccQ, AccV}) ->
                            NR = R + DR,
                            NC = C + DC,

                            if
                                NR >= 0 andalso NR < M andalso NC >= 0 andalso NC < N andalso not sets:is_element({NR, NC}, AccV) ->
                                    NeighborStreetType = lists:nth(NC + 1, lists:nth(NR + 1, Grid)),
                                    ConnectionBackDir = maps:get({DR, DC}, OppositeDirections),
                                    NeighborAllowedDirs = maps:get(NeighborStreetType, StreetConnections),

                                    if
                                        lists:member(ConnectionBackDir, NeighborAllowedDirs) ->
                                            {queue:in({NR, NC}, AccQ), sets:add({NR, NC}, AccV)};
                                        true ->
                                            {AccQ, AccV}
                                    end;
                                true ->
                                    {AccQ, AccV}
                            end
                        end, {CurrentQueue, Visited}, AllowedDirs),

                    bfs(NextQueue, NextVisited, Grid, M, N, StreetConnections, OppositeDirections)
            end;
        {empty, _} ->
            false
    end.