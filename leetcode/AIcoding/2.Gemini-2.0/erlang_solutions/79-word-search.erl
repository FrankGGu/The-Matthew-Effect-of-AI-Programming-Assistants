-module(word_search).
-export([exist/2]).

exist(Board, Word) ->
  {Rows, Cols} = board_size(Board),
  lists:any(fun(Row) ->
              lists:any(fun(Col) ->
                          search(Board, Row, Col, Word, Rows, Cols, [])
                        end, lists:seq(0, Cols - 1))
            end, lists:seq(0, Rows - 1)).

board_size(Board) ->
  case Board of
    [] -> {0, 0};
    [Row | _] -> {length(Board), length(Row)}
  end.

search(Board, Row, Col, [], _, _, _) ->
  true;
search(Board, Row, Col, [H | T], Rows, Cols, Visited) ->
  case is_valid(Row, Col, Rows, Cols, Visited) of
    true ->
      case get_char(Board, Row, Col) of
        H ->
          NewVisited = [{Row, Col} | Visited],
          search(Board, Row - 1, Col, T, Rows, Cols, NewVisited) orelse
          search(Board, Row + 1, Col, T, Rows, Cols, NewVisited) orelse
          search(Board, Row, Col - 1, T, Rows, Cols, NewVisited) orelse
          search(Board, Row, Col + 1, T, Rows, Cols, NewVisited);
        _ ->
          false
      end;
    false ->
      false
  end.

is_valid(Row, Col, Rows, Cols, Visited) ->
  Row >= 0 andalso Row < Rows andalso
  Col >= 0 andalso Col < Cols andalso
  not lists:member({Row, Col}, Visited).

get_char(Board, Row, Col) ->
  lists:nth(Col + 1, lists:nth(Row + 1, Board)).