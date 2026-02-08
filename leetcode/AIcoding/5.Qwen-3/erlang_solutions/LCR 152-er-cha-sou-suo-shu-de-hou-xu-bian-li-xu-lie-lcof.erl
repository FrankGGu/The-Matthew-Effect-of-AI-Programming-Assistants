-module(verify_postorder).
-export([verifyPostorder/1]).

verifyPostorder([]) -> true;
verifyPostorder([X]) -> true;
verifyPostorder(Seq) ->
    verifyPostorder(Seq, -infinity, infinity).

verifyPostorder([], _, _) -> true;
verifyPostorder([X | Rest], Low, High) ->
    if
        X =< Low -> false;
        X >= High -> false;
        true ->
            Left = lists:filter(fun(Y) -> Y < X end, Rest),
            Right = lists:filter(fun(Y) -> Y > X end, Rest),
            verifyPostorder(Left, Low, X) andalso verifyPostorder(Right, X, High)
    end.