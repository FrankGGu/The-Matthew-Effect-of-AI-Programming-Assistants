-module(solution).
-export([exist/2]).

exist(Board, Word) ->
    Rows = length(Board),
    Cols = length(hd(Board)),

    lists:any(fun(R) ->
        lists:any(fun(C) ->
            dfs(R, C, 0, Board, Word, Rows, Cols, sets:new())
        end, lists:seq(0, Cols - 1))
    end, lists:seq(0, Rows - 1)).

dfs(_R, _C, K, _Board, Word, _Rows, _Cols, _Visited) when K >= length(Word) ->
    true;
dfs(R, C, _K, _Board, _Word, Rows, Cols, _Visited) when 
    R < 0 or R >= Rows or C < 0 or C >= Cols ->
    false;
dfs(R, C, _K, _Board, _Word, _Rows, _Cols, Visited) when 
    sets:is_element({R, C}, Visited) ->
    false;
dfs(R, C, K, Board, Word, Rows, Cols, Visited) ->
    CharFromBoard = lists:nth(C + 1, lists:nth(R + 1, Board)),
    CharFromWord = lists:nth(K + 1, Word),

    if 
        CharFromBoard =/= CharFromWord ->
            false;
        true ->
            NewVisited = sets:add_element({R, C}, Visited),
            dfs(R - 1, C, K + 1, Board, Word, Rows, Cols, NewVisited) orelse
            dfs(R + 1, C, K + 1, Board, Word, Rows, Cols, NewVisited) orelse
            dfs(R, C - 1, K + 1, Board, Word, Rows, Cols, NewVisited) orelse
            dfs(R, C + 1, K + 1, Board, Word, Rows, Cols, NewVisited)
    end.