-module(solution).
-export([furthest_distance/1]).

furthest_distance(Moves) ->
    lists:foldl(fun
        (x, {X, Y}) -> case x of
            "L" -> {X - 1, Y};
            "R" -> {X + 1, Y};
            "U" -> {X, Y + 1};
            "D" -> {X, Y - 1}
        end
    end, {0, 0}, Moves),
    max(abs(X) + abs(Y), 0) where {X, Y} = lists:foldl(fun
        (x, {X, Y}) -> case x of
            "L" -> {X - 1, Y};
            "R" -> {X + 1, Y};
            "U" -> {X, Y + 1};
            "D" -> {X, Y - 1}
        end
    end, {0, 0}, Moves).