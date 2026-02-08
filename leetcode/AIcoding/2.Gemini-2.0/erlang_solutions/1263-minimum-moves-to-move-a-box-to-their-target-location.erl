-module(minimum_moves).
-export([min_push_box/1]).

min_push_box(Grid) ->
  {Rows, Cols} = {length(Grid), length(hd(Grid))},
  {BoxRow, BoxCol} = find_item(Grid, 'B'),
  {TargetRow, TargetCol} = find_item(Grid, 'T'),
  {PlayerRow, PlayerCol} = find_item(Grid, 'S'),

  State0 = {{BoxRow, BoxCol}, {PlayerRow, PlayerCol}},
  Queue = gb_sets:add(State0, gb_sets:empty()),
  Visited = gb_sets:add(State0, gb_sets:empty()),
  Distance = gb_trees:enter(State0, 0, gb_trees:empty()),

  min_push_box_helper(Grid, Rows, Cols, TargetRow, TargetCol, Queue, Visited, Distance).

min_push_box_helper(_Grid, _Rows, _Cols, TargetRow, TargetCol, Queue, _Visited, Distance) ->
  case gb_sets:is_empty(Queue) of
    true -> -1;
    false ->
      {State, NewQueue} = gb_sets:take_smallest(Queue),
      {{BoxRow, BoxCol}, {PlayerRow, PlayerCol}} = State,
      Dist = gb_trees:lookup(State, Distance),

      case {BoxRow, BoxCol} =:= {TargetRow, TargetCol} of
        true -> Dist;
        false ->
          Neighbors = get_neighbors(BoxRow, BoxCol, PlayerRow, PlayerCol, _Grid),
          {NewQueue2, NewVisited, NewDistance} = lists:foldl(
            fun({NewBoxRow, NewBoxCol, NewPlayerRow, NewPlayerCol}, {AccQueue, AccVisited, AccDistance}) ->
              NewState = {{NewBoxRow, NewBoxCol}, {NewPlayerRow, NewPlayerCol}},
              case gb_sets:is_element(NewState, AccVisited) of
                true -> {AccQueue, AccVisited, AccDistance};
                false ->
                  {NewAccQueue, NewAccVisited, NewAccDistance} =
                    case gb_trees:is_defined(NewState, AccDistance) of
                      true ->
                        OldDist = gb_trees:lookup(NewState, AccDistance),
                        if Dist + 1 < OldDist ->
                          {gb_sets:add(NewState, AccQueue), gb_sets:add(NewState, AccVisited), gb_trees:enter(NewState, Dist + 1, AccDistance)}
                        else
                          {AccQueue, AccVisited, AccDistance}
                        end;
                      false ->
                        {gb_sets:add(NewState, AccQueue), gb_sets:add(NewState, AccVisited), gb_trees:enter(NewState, Dist + 1, AccDistance)}
                    end,
                  {NewAccQueue, NewAccVisited, NewAccDistance}
              end
            end,
            {NewQueue, Visited, Distance},
            Neighbors
          ),
          min_push_box_helper(_Grid, _Rows, _Cols, TargetRow, TargetCol, NewQueue2, NewVisited, NewDistance)
      end
  end.

find_item(Grid, Item) ->
  find_item_helper(Grid, Item, 0, 0).

find_item_helper([], _Item, _Row, _Col) ->
  throw(not_found);
find_item_helper([Row | Rest], Item, RowIndex, _Col) ->
  case find_item_in_row(Row, Item, RowIndex, 0) of
    {ok, ColIndex} -> {RowIndex, ColIndex};
    error -> find_item_helper(Rest, Item, RowIndex + 1, _Col)
  end.

find_item_in_row([], _Item, _Row, _Col) ->
  error;
find_item_in_row([Item | Rest], Item, Row, Col) ->
  {ok, Col};
find_item_in_row([_ | Rest], Item, Row, Col) ->
  find_item_in_row(Rest, Item, Row, Col + 1).

get_neighbors(BoxRow, BoxCol, PlayerRow, PlayerCol, Grid) ->
  Neighbors = [],
  Neighbors1 = try_move(Grid, BoxRow, BoxCol, PlayerRow, PlayerCol, -1, 0),
  Neighbors2 = try_move(Grid, BoxRow, BoxCol, PlayerRow, PlayerCol, 1, 0),
  Neighbors3 = try_move(Grid, BoxRow, BoxCol, PlayerRow, PlayerCol, 0, -1),
  Neighbors4 = try_move(Grid, BoxRow, BoxCol, PlayerRow, PlayerCol, 0, 1),

  lists:flatten([Neighbors1, Neighbors2, Neighbors3, Neighbors4]).

try_move(Grid, BoxRow, BoxCol, PlayerRow, PlayerCol, Dr, Dc) ->
  NewPlayerRow = BoxRow - Dr,
  NewPlayerCol = BoxCol - Dc,
  NewBoxRow = BoxRow + Dr,
  NewBoxCol = BoxCol + Dc,
  case is_valid(Grid, NewPlayerRow, NewPlayerCol) andalso is_valid(Grid, NewBoxRow, NewBoxCol) of
    true ->
      case element(NewPlayerRow + 1, element(NewPlayerCol + 1, Grid)) =/= '#' andalso
           element(NewBoxRow + 1, element(NewBoxCol + 1, Grid)) =/= '#' andalso
           can_reach(Grid, PlayerRow, PlayerCol, NewPlayerRow, NewPlayerCol, BoxRow, BoxCol) of
        true -> [{NewBoxRow, NewBoxCol, NewPlayerRow, NewPlayerCol}];
        false -> []
      end;
    false ->
      []
  end.

is_valid(Grid, Row, Col) ->
  Rows = length(Grid),
  Cols = length(hd(Grid)),
  Row >= 0 andalso Row < Rows andalso Col >= 0 andalso Col < Cols.

can_reach(Grid, StartRow, StartCol, EndRow, EndCol, BoxRow, BoxCol) ->
  Visited = gb_sets:add({StartRow, StartCol}, gb_sets:empty()),
  Queue = [ {StartRow, StartCol} ],
  can_reach_helper(Grid, EndRow, EndCol, BoxRow, BoxCol, Queue, Visited).

can_reach_helper(_Grid, EndRow, EndCol, _BoxRow, _BoxCol, [], _Visited) ->
  false;
can_reach_helper(Grid, EndRow, EndCol, BoxRow, BoxCol, [ {Row, Col} | Rest ], Visited) ->
  case {Row, Col} =:= {EndRow, EndCol} of
    true -> true;
    false ->
      Neighbors = get_neighbors_no_box(Row, Col, Grid, BoxRow, BoxCol),
      {NewRest, NewVisited} = lists:foldl(
        fun({NewRow, NewCol}, {AccRest, AccVisited}) ->
          case gb_sets:is_element({NewRow, NewCol}, AccVisited) of
            true -> {AccRest, AccVisited};
            false -> {AccRest ++ [{NewRow, NewCol}], gb_sets:add({NewRow, NewCol}, AccVisited)}
          end
        end,
        {Rest, Visited},
        Neighbors
      ),
      can_reach_helper(Grid, EndRow, EndCol, BoxRow, BoxCol, NewRest, NewVisited)
  end.

get_neighbors_no_box(Row, Col, Grid, BoxRow, BoxCol) ->
  Neighbors = [],
  Neighbors1 = try_move_no_box(Grid, Row, Col, -1, 0, BoxRow, BoxCol),
  Neighbors2 = try_move_no_box(Grid, Row, Col, 1, 0, BoxRow, BoxCol),
  Neighbors3 = try_move_no_box(Grid, Row, Col, 0, -1, BoxRow, BoxCol),
  Neighbors4 = try_move_no_box(Grid, Row, Col, 0, 1, BoxRow, BoxCol),
  lists:flatten([Neighbors1, Neighbors2, Neighbors3, Neighbors4]).

try_move_no_box(Grid, Row, Col, Dr, Dc, BoxRow, BoxCol) ->
  NewRow = Row + Dr,
  NewCol = Col + Dc,
  case is_valid(Grid, NewRow,