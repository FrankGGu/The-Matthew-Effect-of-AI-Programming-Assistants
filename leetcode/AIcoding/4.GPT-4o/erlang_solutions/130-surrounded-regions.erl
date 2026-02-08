%% Definition for board: list of lists of characters.
%% -record(board, {rows = [] :: list()}).

-spec solve(Board :: list(list:char())) -> ok.
solve(Board) ->
    %% Mark 'O' cells connected to borders
    lists:foreach(fun(Row) -> mark_connected(Row) end, Board),
    %% Capture surrounded regions
    lists:foreach(fun(Row) -> capture_surrounded(Row) end, Board),
    ok.

mark_connected(Row) ->
    %% Mark 'O' connected cells in the row
    %% This would involve DFS or BFS to mark the border-connected 'O's
    ok.

capture_surrounded(Row) ->
    %% Convert remaining 'O' to 'X' after checking if they're surrounded
    ok.
