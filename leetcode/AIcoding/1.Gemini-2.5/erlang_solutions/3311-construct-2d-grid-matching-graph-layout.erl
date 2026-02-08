-module(solution).

-export([construct_grid/2]).

construct_grid(NodesCount, _Edges) ->
    R = erlang:ceil(erlang:sqrt(NodesCount)),
    C = R,
    generate_grid_rows(0, R, C, NodesCount).

generate_grid_rows(RowIdx, R, C, NodesCount) when RowIdx < R ->
    Row = generate_grid_cols(RowIdx, 0, C, NodesCount),
    [Row | generate_grid_rows(RowIdx + 1, R, C, NodesCount)];
generate_grid_rows(_RowIdx, _R, _C, _NodesCount) ->
    [].

generate_grid_cols(RowIdx, ColIdx, C, NodesCount) when ColIdx < C ->
    NodeId = RowIdx * C + ColIdx + 1,
    Value = case NodeId =< NodesCount of
                true -> NodeId;
                false -> 0
            end,
    [Value | generate_grid_cols(RowIdx, ColIdx + 1, C, NodesCount)];
generate_grid_cols(_RowIdx, _ColIdx, _C, _NodesCount) ->
    [].