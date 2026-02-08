-module(solution).
-export([count_paths/2]).

count_paths(Matrix, Target) ->
  count_paths_helper(Matrix, Target, 0, 0, 0, 0, []).

count_paths_helper(Matrix, Target, Row, Col, Xor, Count, Visited) ->
  case is_valid(Matrix, Row, Col, Visited) of
    false ->
      Count;
    true ->
      NewXor = Xor bxor lists:nth(Col + 1, lists:nth(Row + 1, Matrix)),
      NewCount = case NewXor =:= Target of
                   true -> Count + 1;
                   false -> Count
                 end,
      NewVisited = [{Row, Col} | Visited],
      NewCount1 = count_paths_helper(Matrix, Target, Row + 1, Col, NewXor, NewCount, NewVisited),
      count_paths_helper(Matrix, Target, Row, Col + 1, NewXor, NewCount1, NewVisited)
  end.

is_valid(Matrix, Row, Col, Visited) ->
  NumRows = length(Matrix),
  case NumRows > 0 of
    true ->
      NumCols = length(lists:nth(1, Matrix)),
      Row >= 0 andalso Row < NumRows andalso Col >= 0 andalso Col < NumCols andalso not lists:member({Row, Col}, Visited);
    false ->
      false
  end.