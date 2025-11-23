-module(robot_return).
-export([judgeCircle/1]).

judgeCircle(Moves) ->
  {X, Y} = lists:foldl(fun(Move, {XAcc, YAcc}) ->
    case Move of
      $U -> {XAcc, YAcc + 1};
      $D -> {XAcc, YAcc - 1};
      $L -> {XAcc - 1, YAcc};
      $R -> {XAcc + 1, YAcc}
    end
  end, {0, 0}, Moves),
  X == 0 andalso Y == 0.