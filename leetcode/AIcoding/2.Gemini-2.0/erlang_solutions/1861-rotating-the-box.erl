-module(rotating_box).
-export([rotating_the_box/1]).

rotating_the_box(Box) ->
  {Rows, Cols} = {length(Box), length(hd(Box))},
  NewBox = lists:duplicate(Cols, lists:duplicate(Rows, '.')),
  rotate(Box, Rows, Cols, NewBox).

rotate(Box, Rows, Cols, NewBox) ->
  lists:foldl(
    fun(R, AccNewBox) ->
      lists:foldl(
        fun(C, AccNewBox2) ->
          case lists:nth(C+1, lists:nth(R+1, Box)) of
            '*' ->
              lists:nth(Cols-C, lists:nth(R+1, AccNewBox2)) ! '*';
            '#' ->
              find_empty_spot(AccNewBox2, R+1, Cols-C, Rows),
              lists:nth(Cols-C, lists:nth(R+1, AccNewBox2)) ! '#';
            '.' ->
              ok
          end,
        AccNewBox,
        lists:seq(0, Cols-1)
      )
    end,
    NewBox,
    lists:seq(0, Rows-1)
  ),
  lists:map(fun(Row) -> lists_to_binary(Row) end, lists:map(fun(Row) -> lists:reverse(Row) end, NewBox)).

find_empty_spot(NewBox, Row, Col, Rows) ->
  find_empty_spot_helper(NewBox, Row, Col, Rows, Rows).

find_empty_spot_helper(NewBox, Row, Col, Rows, I) ->
  case I of
    0 ->
      ok;
    _ ->
      case lists:nth(Col, lists:nth(I, NewBox)) of
        '*' ->
          ok;
        '#' ->
          ok;
        '.' ->
          lists:nth(Col, lists:nth(I, NewBox)) ! '#',
          lists:nth(Col, lists:nth(Row, NewBox)) ! '.'
      end,
      find_empty_spot_helper(NewBox, Row, Col, Rows, I - 1)
  end.