-module(shortest_path_all_keys).
-export([shortest_path/1]).

shortest_path(Grid) ->
  {Rows, Cols} = {length(Grid), length(hd(Grid))},
  {StartRow, StartCol, NumKeys} = find_start_and_keys(Grid),
  Q = queue:new(),
  queue:in({{StartRow, StartCol, 0, 0}, 0}, Q1) ->
  Visited = sets:new(),
  shortest_path_helper(Grid, Rows, Cols, NumKeys, Q1, Visited).

find_start_and_keys(Grid) ->
  find_start_and_keys_helper(Grid, 0, 0, 0, 0).

find_start_and_keys_helper([], _, _, Start, Keys) ->
  {element(1, Start), element(2, Start), Keys};
find_start_and_keys_helper([Row | Rest], RowIndex, ColIndex, Start, Keys) ->
  {NewStart, NewKeys} = find_start_in_row(Row, RowIndex, 0, Start, Keys),
  find_start_and_keys_helper(Rest, RowIndex + 1, ColIndex, NewStart, NewKeys).

find_start_in_row([], _, _, Start, Keys) ->
  {Start, Keys};
find_start_in_row([Cell | Rest], RowIndex, ColIndex, Start, Keys) ->
  {NewStart, NewKeys} =
    case Cell of
      $. -> {Start, Keys};
      @"@" -> {{RowIndex, ColIndex}, Keys};
      C when C >= $a, C =< $z -> {Start, Keys + 1};
      _ -> {Start, Keys}
    end,
  find_start_in_row(Rest, RowIndex, ColIndex + 1, NewStart, NewKeys).

shortest_path_helper(Grid, Rows, Cols, NumKeys, Q, Visited) ->
  case queue:is_empty(Q) of
    true -> -1;
    false ->
      {{Row, Col, Keys, Steps}, Q1} = queue:out(Q),
      case sets:is_element({Row, Col, Keys}, Visited) of
        true -> shortest_path_helper(Grid, Rows, Cols, NumKeys, Q1, Visited);
        false ->
          case Keys =:= (1 bsl NumKeys) - 1 of
            true -> Steps;
            false ->
              NewVisited = sets:add_element({Row, Col, Keys}, Visited),
              NewQ = add_neighbors(Grid, Rows, Cols, NumKeys, Row, Col, Keys, Steps, Q1),
              shortest_path_helper(Grid, Rows, Cols, NumKeys, NewQ, NewVisited)
          end
      end
  end.

add_neighbors(Grid, Rows, Cols, NumKeys, Row, Col, Keys, Steps, Q) ->
  Neighbors = [{Row - 1, Col}, {Row + 1, Col}, {Row, Col - 1}, {Row, Col + 1}],
  lists:foldl(
    fun({NewRow, NewCol}, AccQ) ->
      case is_valid_move(Grid, Rows, Cols, NewRow, NewCol, Keys) of
        true -> queue:in({{NewRow, NewCol, update_keys(Grid, NewRow, NewCol, Keys), Steps + 1}, AccQ});
        false -> AccQ
      end
    end,
    Q,
    Neighbors
  ).

is_valid_move(Grid, Rows, Cols, Row, Col, Keys) ->
  case Row < 0 orelse Row >= Rows orelse Col < 0 orelse Col >= length(hd(Grid)) of
    true -> false;
    false ->
      Cell = lists:nth(Col + 1, lists:nth(Row + 1, Grid)),
      case Cell of
        # -> false;
        L when L >= $A, L =< $Z ->
          KeyIndex = L - $A,
          (Keys band (1 bsl KeyIndex)) > 0;
        _ -> true
      end
  end.

update_keys(Grid, Row, Col, Keys) ->
  Cell = lists:nth(Col + 1, lists:nth(Row + 1, Grid)),
  case Cell of
    K when K >= $a, K =< $z ->
      KeyIndex = K - $a,
      Keys bor (1 bsl KeyIndex);
    _ -> Keys
  end.