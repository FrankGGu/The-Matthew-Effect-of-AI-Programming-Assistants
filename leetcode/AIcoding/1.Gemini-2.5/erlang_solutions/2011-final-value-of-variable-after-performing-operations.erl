-module(solution).
-export([finalValueAfterOperations/1]).

finalValueAfterOperations(Operations) ->
    lists:foldl(
        fun(Op, Acc) ->
            case Op of
                "--X" -> Acc - 1;
                "X--" -> Acc - 1;
                "++X" -> Acc + 1;
                "X++" -> Acc + 1
            end
        end,
        0,
        Operations
    ).