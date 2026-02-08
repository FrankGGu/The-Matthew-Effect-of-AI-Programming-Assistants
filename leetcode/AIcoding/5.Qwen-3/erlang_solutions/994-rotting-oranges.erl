-module(rotting_oranges).
-export([oranges_rotting/1]).

oranges_rotting(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Queue = collect_rotten(Grid, 0, 0, []),
    {Rotten, Fresh} = count_fresh(Grid, 0, 0, 0, 0),
    if
        Fresh == 0 -> 0;
        true -> bfs(Grid, Queue, 0, Rows, Cols, Rotten, Fresh)
    end.

collect_rotten([], _, _, Acc) -> Acc;
collect_rotten([Row | Rest], RowIdx, ColIdx, Acc) ->
    case Row of
        [H | T] when H == 2 ->
            collect_rotten([T ++ [H] | Rest], RowIdx, ColIdx + 1, [{RowIdx, ColIdx} | Acc]);
        _ ->
            collect_rotten([Row | Rest], RowIdx, ColIdx + 1, Acc)
    end.

count_fresh([], _, _, Rotten, Fresh) -> {Rotten, Fresh};
count_fresh([Row | Rest], RowIdx, ColIdx, Rotten, Fresh) ->
    case Row of
        [H | T] when H == 2 ->
            count_fresh([T ++ [H] | Rest], RowIdx, ColIdx + 1, Rotten + 1, Fresh);
        [H | T] when H == 1 ->
            count_fresh([T ++ [H] | Rest], RowIdx, ColIdx + 1, Rotten, Fresh + 1);
        _ ->
            count_french([Row | Rest], RowIdx, ColIdx + 1, Rotten, Fresh)
    end.

bfs(Grid, [], Time, _, _, Rotten, _) when Rotten == 0 -> Time;
bfs(Grid, Queue, Time, Rows, Cols, Rotten, Fresh) ->
    NextQueue = [],
    NewRotten = 0,
    NewFresh = 0,
    lists:foreach(fun({R, C}) ->
        Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
        lists:foreach(fun({DR, DC}) ->
            NR = R + DR,
            NC = C + DC,
            if
                NR >= 0, NR < Rows, NC >= 0, NC < Cols, lists:nth(NR + 1, Grid) -- [NC] == 1 ->
                    lists:setelement(NR + 1, Grid, lists:sublist(lists:nth(NR + 1, Grid), NC) ++ [2] ++ lists:nthtail(NC + 1, lists:nth(NR + 1, Grid))),
                    NewRotten = NewRotten + 1,
                    NewFresh = NewFresh - 1,
                    NextQueue = NextQueue ++ [{NR, NC}];
                true -> ok
            end
        end, Directions)
    end, Queue),
    if
        NewFresh == 0 -> Time + 1;
        true -> bfs(Grid, NextQueue, Time + 1, Rows, Cols, Rotten + NewRotten, Fresh + NewFresh)
    end.