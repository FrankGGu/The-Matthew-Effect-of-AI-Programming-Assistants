-module(solution).
-export([max_fruits/1]).

max_fruits(Fruits) ->
    max_fruits(Fruits, 0, 0, 0, 0).

max_fruits([], _, _, Max, _) ->
    Max;
max_fruits([H | T], Index, Left, Max, Right) ->
    case H of
        0 ->
            NewLeft = if Index == 0 -> 0; true -> Left + 1 end,
            NewRight = Right + 1,
            max_fruits(T, Index + 1, NewLeft, max(Max, NewLeft + NewRight), NewRight);
        _ ->
            NewLeft = if Index == 0 -> 0; true -> Left + 1 end,
            NewRight = 0,
            max_fruits(T, Index + 1, NewLeft, max(Max, NewLeft + NewRight), NewRight)
    end.