-module(highest_peak).
-export([highestPeak/1]).

highestPeak(Grid) ->
    Rows = length(Grid),
    Cols = length(lists:nth(1, Grid)),
    MaxHeight = 0,
    Queue = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            case lists:nth(I+1, Grid) -- [J] of
                [0] -> [{I,J,0} | Acc2];
                _ -> Acc2
            end
        end, Acc, lists:seq(0, Cols-1))
    end, [], lists:seq(0, Rows-1)),

    HeightMap = lists:foldl(fun({I,J,H}, Acc) ->
        maps:update({I,J}, H, Acc)
    end, maps:new(), Queue),

    BFS(Queue, HeightMap, Grid, Rows, Cols).

BFS([], HeightMap, _, _, _) ->
    maps:to_list(HeightMap);

BFS([{I,J,H} | Rest], HeightMap, Grid, Rows, Cols) ->
    Directions = [{-1,0}, {1,0}, {0,-1}, {0,1}],
    NewQueue = lists:foldl(fun({DI,DJ}, Acc) ->
        NI = I + DI,
        NJ = J + DJ,
        if
            NI >= 0, NI < Rows, NJ >= 0, NJ < Cols ->
                case maps:get({NI,NJ}, HeightMap, undefined) of
                    undefined ->
                        NewH = H + 1,
                        maps:put({NI,NJ}, NewH, HeightMap),
                        [{NI,NJ,NewH} | Acc];
                    _ ->
                        Acc
                end;
            true ->
                Acc
        end
    end, Rest, Directions),

    BFS(NewQueue, HeightMap, Grid, Rows, Cols).

lists:nth(I+1, Grid) -- [J] ->
    lists:nth(I+1, Grid) -- [J].