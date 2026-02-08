-module(strange_printer_ii).
-export([is_printable_new/1]).

is_printable_new(target_grid) ->
    Rows = length(target_grid),
    Cols = length(hd(target_grid)),
    Colors = lists:seq(1, max_color(target_grid)),

    Bounds = lists:map(fun(Color) -> find_bounds(target_grid, Color, Rows, Cols) end, Colors),

    graph_adj(Bounds, Colors, Rows, Cols) -> Graphs,

    case topological_sort(Graphs) of
        [] -> false;
        _ -> true
    end.

max_color(Grid) ->
    lists:max([lists:max(Row) || Row <- Grid]).

find_bounds(Grid, Color, Rows, Cols) ->
    find_bounds_helper(Grid, Color, Rows, Cols, Cols, Rows, 0, 0).

find_bounds_helper(Grid, Color, Rows, Cols, MinCol, MinRow, MaxCol, MaxRow) ->
    find_bounds_helper(Grid, Color, Rows, Cols, MinCol, MinRow, MaxCol, MaxRow, 1, 1).

find_bounds_helper(Grid, Color, Rows, Cols, MinCol, MinRow, MaxCol, MaxRow, Row, Col) ->
    case Row > Rows of
        true -> {MinCol, MinRow, MaxCol, MaxRow};
        false ->
            case Col > Cols of
                true -> find_bounds_helper(Grid, Color, Rows, Cols, MinCol, MinRow, MaxCol, MaxRow, Row + 1, 1);
                false ->
                    case lists:nth(Col, lists:nth(Row, Grid)) == Color of
                        true ->
                            NewMinCol = min(MinCol, Col),
                            NewMinRow = min(MinRow, Row),
                            NewMaxCol = max(MaxCol, Col),
                            NewMaxRow = max(MaxRow, Row),
                            find_bounds_helper(Grid, Color, Rows, Cols, NewMinCol, NewMinRow, NewMaxCol, NewMaxRow, Row, Col + 1);
                        false ->
                            find_bounds_helper(Grid, Color, Rows, Cols, MinCol, MinRow, MaxCol, MaxRow, Row, Col + 1)
                    end
            end
    end.

graph_adj(Bounds, Colors, Rows, Cols) ->
    lists:foldl(
        fun(Color1, Acc) ->
            {MinCol1, MinRow1, MaxCol1, MaxRow1} = lists:nth(Color1, Bounds),
            Edges = lists:foldl(
                fun(Color2, Acc2) ->
                    case Color1 =:= Color2 of
                        true -> Acc2;
                        false ->
                            {MinCol2, MinRow2, MaxCol2, MaxRow2} = lists:nth(Color2, Bounds),
                            case overlap({MinCol1, MinRow1, MaxCol1, MaxRow1}, {MinCol2, MinRow2, MaxCol2, MaxRow2}) of
                                true -> [{Color2, Color1} | Acc2];
                                false -> Acc2
                            end
                    end
                end, [], Colors
            ),
            [ {Color1, Edges} | Acc]
        end, [], Colors
    ).

overlap({MinCol1, MinRow1, MaxCol1, MaxRow1}, {MinCol2, MinRow2, MaxCol2, MaxRow2}) ->
    MinCol1 =< MaxCol2 andalso MaxCol1 >= MinCol2 andalso
    MinRow1 =< MaxRow2 andalso MaxRow1 >= MinRow2.

topological_sort(Graph) ->
    topological_sort(Graph, [], []).

topological_sort([], Visited, Sorted) ->
    lists:reverse(Sorted);

topological_sort(Graph, Visited, Sorted) ->
    case find_no_incoming_edges(Graph, Visited) of
        [] -> [];
        Nodes ->
            NewGraph = remove_nodes(Graph, Nodes),
            NewVisited = Visited ++ Nodes,
            NewSorted = Sorted ++ Nodes,
            topological_sort(NewGraph, NewVisited, NewSorted)
    end.

find_no_incoming_edges(Graph, Visited) ->
    Vertices = [V || {V, _} <- Graph],
    IncomingEdges = lists:foldl(
        fun({_, Edges}, Acc) ->
            Acc ++ Edges
        end, [], Graph),

    [V || V <- Vertices, not lists:member(V, IncomingEdges), not lists:member(V, Visited)].

remove_nodes(Graph, Nodes) ->
    NewGraph = [ {V, lists:filter(fun(N) -> not lists:member(N, Nodes) end, Edges)} || {V, Edges} <- Graph, not lists:member(V, Nodes)],
    NewGraph.