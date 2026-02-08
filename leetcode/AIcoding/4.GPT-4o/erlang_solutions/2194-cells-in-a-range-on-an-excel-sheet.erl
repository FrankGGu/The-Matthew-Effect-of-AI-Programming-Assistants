-module(solution).
-export([cells_in_range/1]).

cells_in_range(Range) ->
    {Start, End} = parse_range(Range),
    lists:flatmap(fun(Row) -> 
        lists:map(fun(Column) -> Column ++ Row end, lists:seq(Start#column, End#column)) 
    end, lists:seq(Start#row, End#row)).

parse_range(Range) ->
    [StartStr, EndStr] = string:tokens(Range, ":"),
    {parse_cell(StartStr), parse_cell(EndStr)}.

parse_cell(Cell) ->
    Column = list_to_integer(binary_to_list(<<Cell:8>>)),
    Row = list_to_integer(binary_to_list(<<Cell:8>>)),
    {Row, Column}.