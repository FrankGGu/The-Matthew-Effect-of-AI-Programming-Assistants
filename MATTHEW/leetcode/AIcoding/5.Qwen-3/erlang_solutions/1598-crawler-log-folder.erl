-module(solution).
-export([min_operations/1]).

min_operations(Operations) ->
    Depth = 0,
    lists:foldl(fun(Op, Acc) ->
        case Op of
            "../" -> max(Acc - 1, 0);
            "./" -> Acc;
            _ -> Acc + 1
        end
    end, Depth, Operations).