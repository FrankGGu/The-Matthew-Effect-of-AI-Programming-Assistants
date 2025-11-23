-module(ball_fall).
-export([find_ball/1]).

find_ball(Grid) ->
  W = length(hd(Grid)),
  [fall(C, 0, Grid, W) || C <- lists:seq(0, W - 1)].

fall(_Col, H, _Grid, _W) when H >= length(_Grid) ->
  _Col;
fall(_Col, _H, _Grid, _W) when _Col < 0 orelse _Col >= _W ->
  -1;
fall(_Col, _H, _Grid, _W) ->
  case lists:nth(_H + 1, _Grid) of
    Row ->
      case lists:nth(_Col + 1, Row) of
        1 ->
          if _Col + 1 >= _W then
            -1
          else
            case lists:nth(_Col + 2, Row) of
              1 ->
                fall(_Col + 1, _H + 1, _Grid, _W);
              _ ->
                -1
            end
          end;
        -1 ->
          if _Col - 1 < 0 then
            -1
          else
            case lists:nth(_Col, Row) of
              -1 ->
                fall(_Col - 1, _H + 1, _Grid, _W);
              _ ->
                -1
            end
          end
      end
  end.