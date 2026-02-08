-module(solution).
-export([exist/2]).

get_char(Board, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Board)).

exist(_Board, []) ->
    true;
exist(Board, Word) ->
    Rows = length(Board),
    Cols = length(hd(Board)),

    %% Generate all possible starting coordinates
    Coords = [{R, C} || R <- lists:seq(0, Rows - 1), C <- lists:seq(0, Cols - 1)],

    lists:any(fun({R, C}) ->
        Char = get_char(Board, R, C),
        FirstWordChar = hd(Word),
        if Char == FirstWordChar ->
            dfs(Board, tl(Word), R, C, gb_sets:add({R, C}, gb_sets:new()), Rows, Cols);
        true ->
            false
        end
    end, Coords).

dfs(_Board, [], _R, _C, _Visited, _Rows, _Cols) ->
    true;
dfs(Board, Word, R, C, Visited, Rows, Cols) ->
    %% Define directions: {dR, dC} for (row_change, col_change)
    Directions = [{0, 1}, {0, -1}, {1, 0}, {-1, 0}],

    lists:any(fun({dR, dC}) ->
        NewR = R + dR,
        NewC = C + dC,

        %% Check if new coordinates are within board bounds
        if NewR >= 0 andalso NewR < Rows andalso NewC >= 0 andalso NewC < Cols ->
            %% Check if the cell has already been visited in the current path
            if not gb_sets:is_member({NewR, NewC}, Visited) ->
                CurrentChar = get_char(Board, NewR, NewC),
                NextWordChar = hd(Word),
                %% Check if the character in the board matches the next character in the word
                if CurrentChar == NextWordChar ->
                    %% Recursively call dfs for the next character
                    dfs(Board, tl(Word), NewR, NewC, gb_sets:add({NewR, NewC}, Visited), Rows, Cols);
                true ->
                    false
                end;
            true ->
                false
            end;
        true ->
            false
        end
    end, Directions).