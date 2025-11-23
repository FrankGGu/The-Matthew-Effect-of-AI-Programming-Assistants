-module(solution).
-export([exist/2]).

exist(Board, Word) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    lists:any(fun({R, C}) -> 
        search(Board, Word, R, C, 0, lists:duplicate(Rows, lists:duplicate(Cols, false)))
    end, lists:seq(1, Rows * Cols)).

search(Board, Word, R, C, Index, Visited) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    case {R, C, Index} of
        {_, _, L} when L == length(Word) -> true;
        {R, C, L} when R < 1; R > Rows; C < 1; C > Cols -> false;
        {R, C, L} when lists:nth(R, lists:nth(C, Visited)) -> false;
        {R, C, L} when lists:nth(L + 1, lists:nth(R, Board)) =:= lists:nth(L + 1, string:to_list(Word)) ->
            NewVisited = lists:replace_element(R, lists:replace_element(C, true, lists:nth(R, Visited)), Visited),
            search(Board, Word, R + 1, C, L + 1, NewVisited) orelse
            search(Board, Word, R - 1, C, L + 1, NewVisited) orelse
            search(Board, Word, R, C + 1, L + 1, NewVisited) orelse
            search(Board, Word, R, C - 1, L + 1, NewVisited);
        _ -> false
    end.