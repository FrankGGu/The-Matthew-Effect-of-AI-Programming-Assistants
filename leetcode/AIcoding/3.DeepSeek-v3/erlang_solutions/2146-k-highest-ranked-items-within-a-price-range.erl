-module(solution).
-export([highest_ranked_k_items/4]).

highest_ranked_k_items(Grid, Pricing, Start, K) ->
    {Low, High} = Pricing,
    {StartRow, StartCol} = Start,
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = array:new([{size, Rows}, {default, array:new([{size, Cols}, {default, false}])}]),
    Queue = [{StartRow, StartCol, 0, lists:nth(StartRow + 1, lists:nth(StartCol + 1, Grid))}],
    Visited1 = mark_visited(StartRow, StartCol, Visited),
    bfs(Grid, Low, High, Queue, Visited1, Rows, Cols, [], K).

mark_visited(Row, Col, Visited) ->
    RowArray = array:get(Row, Visited),
    NewRowArray = array:set(Col, true, RowArray),
    array:set(Row, NewRowArray, Visited).

bfs(_Grid, _Low, _High, [], _Visited, _Rows, _Cols, Acc, K) when K =< 0 ->
    lists:sublist(lists:keysort(1, Acc), K);
bfs(_Grid, _Low, _High, [], _Visited, _Rows, _Cols, Acc, K) ->
    Sorted = lists:keysort(1, Acc),
    lists:sublist(Sorted, K);
bfs(Grid, Low, High, [{Row, Col, Dist, Price} | Rest], Visited, Rows, Cols, Acc, K) ->
    NewAcc = case (Price >= Low) and (Price =< High) of
                 true -> [{Dist, Price, Row, Col} | Acc];
                 false -> Acc
             end,
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    {NewQueue, NewVisited} = lists:foldl(
        fun({DR, DC}, {Q, V}) ->
            NewRow = Row + DR,
            NewCol = Col + DC,
            if
                NewRow >= 0, NewRow < Rows, NewCol >= 0, NewCol < Cols ->
                    case (not array:get(NewRow, array:get(NewCol, V))) andalso
                         (lists:nth(NewRow + 1, lists:nth(NewCol + 1, Grid)) =/= 0) of
                        true ->
                            NewPrice = lists:nth(NewRow + 1, lists:nth(NewCol + 1, Grid)),
                            NewV = mark_visited(NewRow, NewCol, V),
                            {[{NewRow, NewCol, Dist + 1, NewPrice} | Q], NewV};
                        false ->
                            {Q, V}
                    end;
                true ->
                    {Q, V}
            end
        end,
        {Rest, Visited},
        Directions
    ),
    bfs(Grid, Low, High, NewQueue, NewVisited, Rows, Cols, NewAcc, K).