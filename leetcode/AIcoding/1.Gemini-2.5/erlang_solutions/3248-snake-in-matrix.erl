-module(solution).
-export([is_snake/2]).

is_snake(Matrix, Snake) ->
    case Snake of
        [] -> true;
        [Head | Tail] ->
            Rows = length(Matrix),
            Cols = case Matrix of
                       [] -> 0;
                       [H|_] -> length(H)
                   end,
            lists:any(fun(R) ->
                          lists:any(fun(C) ->
                                        element_at(Matrix, R, C) == Head andalso
                                        dfs(Matrix, Tail, R, C, Rows, Cols, sets:from_list([{R, C}]))
                                    end, lists:seq(0, Cols - 1))
                      end, lists:seq(0, Rows - 1))
    end.

dfs(_Matrix, [], _R, _C, _Rows, _Cols, _Visited) ->
    true;
dfs(Matrix, [NextHead | NextTail], CurrentR, CurrentC, Rows, Cols, Visited) ->
    Neighbors = get_neighbors(CurrentR, CurrentC, Rows, Cols),
    lists:any(fun({NR, NC}) ->
                  not sets:is_element({NR, NC}, Visited) andalso
                  element_at(Matrix, NR, NC) == NextHead andalso
                  dfs(Matrix, NextTail, NR, NC, Rows, Cols, sets:add_element({NR, NC}, Visited))
              end, Neighbors).

element_at(Matrix, R, C) ->
    lists:nth(C + 1, lists:nth(R + 1, Matrix)).

get_neighbors(R, C, Rows, Cols) ->
    PossibleDirs = [-1, 0, 1],
    [ {NR, NC} || DR <- PossibleDirs,
                  DC <- PossibleDirs,
                  (DR /= 0 orelse DC /= 0),
                  NR = R + DR,
                  NC = C + DC,
                  NR >= 0, NR < Rows,
                  NC >= 0, NC < Cols ].