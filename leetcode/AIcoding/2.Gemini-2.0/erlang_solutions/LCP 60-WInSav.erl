-module(leetcode_bubble_shooter).
-export([solve/1]).

solve(Board) ->
  {M, N} = get_dimensions(Board),
  Visited = gb_sets:empty(),
  ToVisit = [ {0, X} || X <- lists:seq(0, N-1), element(X+1, element(1, Board)) == 0 ],
  NewBoard = dfs(Board, ToVisit, Visited),
  lists:usort(NewBoard).

dfs(Board, [], Visited) ->
  Board;
dfs(Board, [Coord|Rest], Visited) ->
  case gb_sets:is_element(Coord, Visited) of
    true ->
      dfs(Board, Rest, Visited);
    false ->
      {Row, Col} = Coord,
      case is_valid(Row, Col, Board) of
        false ->
          dfs(Board, Rest, gb_sets:add(Coord, Visited));
        true ->
          case element(Col+1, element(Row+1, Board)) of
            0 ->
              Neighbors = get_neighbors(Row, Col, Board),
              NewToVisit = lists:foldl(fun(N, Acc) ->
                                             case gb_sets:is_element(N, Visited) of
                                               true -> Acc;
                                               false -> [N|Acc]
                                             end
                                         end, Rest, Neighbors),
              dfs(Board, NewToVisit, gb_sets:add(Coord, Visited));
            _ ->
              dfs(Board, Rest, gb_sets:add(Coord, Visited))
          end
      end
  end.

get_neighbors(Row, Col, Board) ->
  {M, N} = get_dimensions(Board),
  Neighbors = case Row rem 2 of
    0 ->
      [ {Row-1, Col-1}, {Row-1, Col}, {Row, Col-1}, {Row, Col+1}, {Row+1, Col-1}, {Row+1, Col} ];
    1 ->
      [ {Row-1, Col}, {Row-1, Col+1}, {Row, Col-1}, {Row, Col+1}, {Row+1, Col}, {Row+1, Col+1} ]
  end,
  lists:filter(fun({R, C}) -> is_valid(R, C, Board) end, Neighbors).

is_valid(Row, Col, Board) ->
  {M, N} = get_dimensions(Board),
  Row >= 0 and Row < M and Col >= 0 and Col < N.

get_dimensions(Board) ->
  {length(Board), length(element(1, Board))}.