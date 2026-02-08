-module(solution).
-export([reflections/1]).

reflections({X, Y, Dir}) ->
    reflections(X, Y, Dir, 0).

reflections(X, Y, Dir, Count) ->
    case Dir of
        right -> reflections(X + 1, Y, down, Count + 1);
        down -> reflections(X, Y - 1, left, Count + 1);
        left -> reflections(X - 1, Y, up, Count + 1);
        up -> reflections(X, Y + 1, right, Count + 1)
    end.