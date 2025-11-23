-module(jump_game_iv).
-export([min_jumps/1]).

min_jumps(Nums) ->
    N = length(Nums),
    if
        N == 0 -> -1;
        true ->
            Visited = erlset:new(),
            Queue = erlqueue:new(),
            erlqueue:in({0, 0}, Queue),
            erlset:insert(Visited, 0),
            min_jumps_loop(Nums, N, Visited, Queue)
    end.

min_jumps_loop(Nums, N, Visited, Queue) ->
    case erlqueue:out(Queue) of
        {empty, _} -> -1;
        {{Value, Steps}, NewQueue} ->
            Index = Value,
            if
                Index == N - 1 -> Steps;
                true ->
                    Step = element(Index + 1, Nums),
                    NextIndices = [Index + 1, Index - 1, Index + Step],
                    NewVisited = lists:foldl(fun(I, Acc) ->
                        if
                            I >= 0, I < N, not erlset:is_member(Acc, I) ->
                                erlset:insert(Acc, I);
                            true ->
                                Acc
                        end
                    end, Visited, NextIndices),
                    NewQueue2 = lists:foldl(fun(I, Q) ->
                        if
                            I >= 0, I < N, erlset:is_member(NewVisited, I) ->
                                erlqueue:in({I, Steps + 1}, Q);
                            true ->
                                Q
                        end
                    end, NewQueue, NextIndices),
                    min_jumps_loop(Nums, N, NewVisited, NewQueue2)
            end
    end.