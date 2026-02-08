-module(maximum_points).
-export([max_points/2]).

max_points(Grid, Queries) ->
    {M, N} = grid_size(Grid),
    Points = queue:new(),
    queue:in({0, 0, element(1, element(1, Grid))}, Points),
    Visited = sets:new(),
    sets:add({0, 0}, Visited),

    SortedQueries = lists:keysort(1, [{Q, Index} || {Index, Q} <- lists:zip(lists:seq(1, length(Queries)), Queries)]),

    solve(SortedQueries, Grid, Points, Visited, M, N, []).

solve([], _Grid, _Points, _Visited, _M, _N, Acc) ->
    lists:reverse(Acc);
solve([{Query, Index} | Rest], Grid, Points, Visited, M, N, Acc) ->
    {NewPoints, NewVisited, Count} = process_query(Query, Grid, Points, Visited, M, N, 0),
    solve(Rest, Grid, NewPoints, NewVisited, M, N, [{Index, Count} | Acc]).

process_query(Query, Grid, Points, Visited, M, N, Count) ->
    case queue:out(Points) of
        {{value, {Row, Col, Value}}, NewPoints} when Value < Query ->
            NewVisited2 = visit_neighbors(Row, Col, Value, Grid, Visited, M, N, Query, NewPoints),
            NewPoints2 = queue:new(),
            {NewPoints3, NewVisited3} = queue_from_set(NewVisited2, NewPoints2),
            process_query(Query, Grid, NewPoints3, NewVisited3, M, N, Count + 1);
        {{value, _}, NewPoints} ->
            {NewPoints, Visited, Count};
        {empty, _} ->
            {queue:new(), Visited, Count}
    end.

visit_neighbors(Row, Col, Value, Grid, Visited, M, N, Query, Points) ->
    Neighbors = get_neighbors(Row, Col, M, N),
    lists:foldl(
        fun({NewRow, NewCol}, Acc) ->
            case sets:is_element({NewRow, NewCol}, Visited) of
                true ->
                    Acc;
                false ->
                    NewValue = element(NewCol + 1, element(NewRow + 1, Grid)),
                    if
                        NewValue < Query ->
                            sets:add({NewRow, NewCol}, Acc);
                        true ->
                            Acc
                    end
            end
        end,
        Visited,
        Neighbors
    ).

get_neighbors(Row, Col, M, N) ->
    lists:flatten(
        [
            if
                Row > 0 -> [{Row - 1, Col}];
                true -> []
            end,
            if
                Row < M - 1 -> [{Row + 1, Col}];
                true -> []
            end,
            if
                Col > 0 -> [{Row, Col - 1}];
                true -> []
            end,
            if
                Col < N - 1 -> [{Row, Col + 1}];
                true -> []
            end
        ]
    ).

grid_size(Grid) ->
    M = length(Grid),
    N = length(element(1, Grid)),
    {M, N}.

queue_from_set(Set, Queue) ->
    lists:foldl(
        fun(Elem, {Q, V}) ->
            case Elem of
                {Row, Col} ->
                    Value = element(Col + 1, element(Row + 1, element(1, V))),
                    {queue:in({Row, Col, Value}, Q), V}
            end
        end,
        {Queue, Set},
        sets:to_list(Set)
    ).