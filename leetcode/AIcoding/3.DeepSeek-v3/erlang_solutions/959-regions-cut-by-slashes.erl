-module(solution).
-export([regionsBySlashes/1]).

regionsBySlashes(Grid) ->
    N = length(Grid),
    Parent = lists:seq(0, 4 * N * N - 1),
    Count = 4 * N * N,
    lists:foldl(fun(Row, {P, C}) ->
        lists:foldl(fun(Col, {P1, C1}) ->
            process_cell(lists:nth(Col + 1, lists:nth(Row + 1, Grid)), Row, Col, N, P1, C1)
        end, {P, C}, lists:seq(0, N - 1))
    end, {Parent, Count}, lists:seq(0, N - 1)).

process_cell($/, Row, Col, N, Parent, Count) ->
    {P1, C1} = union(4 * (Row * N + Col) + 0, 4 * (Row * N + Col) + 3, Parent, Count),
    {P2, C2} = union(4 * (Row * N + Col) + 1, 4 * (Row * N + Col) + 2, P1, C1),
    {P2, C2};
process_cell($\\, Row, Col, N, Parent, Count) ->
    {P1, C1} = union(4 * (Row * N + Col) + 0, 4 * (Row * N + Col) + 1, Parent, Count),
    {P2, C2} = union(4 * (Row * N + Col) + 2, 4 * (Row * N + Col) + 3, P1, C1),
    {P2, C2};
process_cell($ , Row, Col, N, Parent, Count) ->
    {P1, C1} = union(4 * (Row * N + Col) + 0, 4 * (Row * N + Col) + 1, Parent, Count),
    {P2, C2} = union(4 * (Row * N + Col) + 1, 4 * (Row * N + Col) + 2, P1, C1),
    {P3, C3} = union(4 * (Row * N + Col) + 2, 4 * (Row * N + Col) + 3, P2, C2),
    {P3, C3}.

union(X, Y, Parent, Count) ->
    RootX = find(X, Parent),
    RootY = find(Y, Parent),
    if
        RootX =:= RootY -> {Parent, Count};
        true -> 
            NewParent = setelement(RootY + 1, Parent, RootX),
            {NewParent, Count - 1}
    end.

find(X, Parent) ->
    if
        element(X + 1, Parent) =:= X -> X;
        true -> 
            P = find(element(X + 1, Parent), Parent),
            setelement(X + 1, Parent, P),
            P
    end.