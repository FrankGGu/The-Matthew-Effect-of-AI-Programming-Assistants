-module(valid_boomerang).
-export([is_boomerang/1]).

is_boomerang([A,B,C]) ->
    [[X1,Y1],[X2,Y2],[X3,Y3]] = [A,B,C],
    (Y2 - Y1)*(X3 - X1) =:= (Y3 - Y1)*(X2 - X1).

is_boomerang(_) ->
    false.