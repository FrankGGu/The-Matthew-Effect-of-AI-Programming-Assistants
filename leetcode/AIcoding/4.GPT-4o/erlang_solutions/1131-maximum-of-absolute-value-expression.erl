-module(solution).
-export([maxAbsValExpr/2]).

maxAbsValExpr(Xs, Ys) ->
    Max = lists:max(
        [lists:max([lists:max([abs(Xs1 - Xs2) + abs(Ys1 - Ys2) || {Xs1, Ys1} <- lists:zip(Xs, Ys), {Xs2, Ys2} <- lists:zip(Xs, Ys)]) || Sign <- [1, -1]] || Sign2 <- [1, -1]])
        || Sign1 <- [1, -1]
    ),
    Max.