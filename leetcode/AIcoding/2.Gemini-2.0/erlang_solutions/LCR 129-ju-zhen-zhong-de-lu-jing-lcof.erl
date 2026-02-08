-module(letter_maze).
-export([exist/2]).

exist(Board, Word) ->
  Rows = length(Board),
  Cols = length(hd(Board)),
  lists:any(fun(Row) ->
              lists:any(fun(Col) ->
                          dfs(Board, Word, Row, Col, Rows, Cols, [])
                        end, lists:seq(0, Cols - 1))
            end, lists:seq(0, Rows - 1)).

dfs(Board, [], _, _, _, _, _) ->
  true;
dfs(Board, [Char | Rest], Row, Col, Rows, Cols, Visited) ->
  Row >= 0 andalso Row < Rows andalso Col >= 0 andalso Col < Cols andalso not lists:member({Row, Col}, Visited) andalso
    lists:nth(Col + 1, lists:nth(Row + 1, Board)) == Char andalso
      (dfs(Board, Rest, Row + 1, Col, Rows, Cols, [{Row, Col} | Visited]) orelse
       dfs(Board, Rest, Row - 1, Col, Rows, Cols, [{Row, Col} | Visited]) orelse
       dfs(Board, Rest, Row, Col + 1, Rows, Cols, [{Row, Col} | Visited]) orelse
       dfs(Board, Rest, Row, Col - 1, Rows, Cols, [{Row, Col} | Visited])).