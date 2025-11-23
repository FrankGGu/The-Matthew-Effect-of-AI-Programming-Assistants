-module(solution).
-export([shortestPath/1]).

shortestPath(Matrix) ->
    N = length(Matrix),
    if
        N == 0 -> -1;
        true ->
            Visited = array:new(N, {default, false}),
            Queue = queue:from_list([{0, 0, 0}]),
            shortestPathHelper(Matrix, Visited, Queue, N)
    end.

shortestPathHelper(Matrix, Visited, Queue, N) ->
    case queue:out(Queue) of
        {empty, _} -> -1;
        {{value, {X, Y, Dist}}, NewQueue} ->
            if
                X == N-1 andalso Y == N-1 -> Dist;
                true ->
                    Directions = [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}],
                    lists:foreach(fun({DX, DY}) ->
                        NX = X + DX,
                        NY = Y + DY,
                        if
                            NX >= 0 andalso NX < N andalso NY >= 0 andalso NY < N andalso not array:get(NY, array:get(NX, Visited)) andalso matrix_get(Matrix, NX, NY) == 0 ->
                                Visited2 = array:set(NY, array:set(NX, true, array:get(NY, Visited)), Visited),
                                Queue2 = queue:in({NX, NY, Dist + 1}, NewQueue),
                                shortestPathHelper(Matrix, Visited2, Queue2, N);
                            true ->
                                ok
                        end
                    end, Directions),
                    shortestPathHelper(Matrix, Visited, NewQueue, N)
            end
    end.

matrix_get(Matrix, I, J) ->
    lists:nth(I + 1, Matrix),
    lists:nth(J + 1, lists:nth(I + 1, Matrix)).