-module(Spreadsheet).
-export([new/0, set/3, get/2, sum/2, update/3]).

-record(cell, {value = 0, formula = undefined}).

new() ->
    dict:new().

set(Spreadsheet, Cell, Value) ->
    dict:store(Cell, #cell{value = Value}, Spreadsheet).

get(Spreadsheet, Cell) ->
    case dict:find(Cell, Spreadsheet) of
        {ok, #cell{value = Value}} -> Value;
        error -> 0
    end.

sum(Spreadsheet, Cells) ->
    lists:sum([get(Spreadsheet, Cell) || Cell <- Cells]).

update(Spreadsheet, Cell, Formula) ->
    {Result, NewSpreadsheet} = evaluate_formula(Spreadsheet, Formula),
    NewSpreadsheet1 = dict:store(Cell, #cell{value = Result, formula = Formula}, NewSpreadsheet),
    {Result, NewSpreadsheet1}.

evaluate_formula(Spreadsheet, Formula) ->
    case parse_formula(Formula) of
        {ok, Cells} -> 
            Result = sum(Spreadsheet, Cells),
            {Result, Spreadsheet};
        error ->
            {0, Spreadsheet}
    end.

parse_formula(Formula) ->
    Cells = lists:filter(fun(C) -> is_cell(C) end, string:tokens(Formula, "+")),
    {ok, Cells}.

is_cell(Cell) ->
    %% Assume cells are represented as strings like "A1", "B2", etc.
    string:to_integer(Cell) =:= error.