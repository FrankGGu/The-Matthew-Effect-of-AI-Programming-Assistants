-module(solution).
-export([least_ops_express_target/2]).

least_ops_express_target(X, Y) ->
    least_ops_express_target_helper(X, Y).

least_ops_express_target_helper(X, Y) ->
    case Y of
        0 -> 0;
        _ -> least_ops_helper(Y, 1, 0, X)
    end.

least_ops_helper(0, _Count, Acc, _) -> Acc;
least_ops_helper(Y, Count, Acc, X) ->
    NextAcc = Acc + 1,
    NewY = Y - 1,
    least_ops_helper(NewY, Count + 1, NextAcc, X).