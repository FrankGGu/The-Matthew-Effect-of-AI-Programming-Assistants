-module(solution).
-export([cal_statistics/2]).

cal_statistics(N, Operations) ->
    lists:foldl(fun({Op, X}, Acc) ->
        case Op of
            "add" -> Acc + X;
            "subtract" -> Acc - X;
            "multiply" -> Acc * X;
            "divide" -> Acc div X
        end
    end, 0, Operations).