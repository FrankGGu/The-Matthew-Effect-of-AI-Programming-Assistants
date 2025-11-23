-module(solution).
-export([largestValues/1]).

largestValues(Tree) ->
    largestValues(Tree, 1, []).

largestValues(nil, _, Acc) -> 
    Acc;
largestValues(Tree, Level, Acc) ->
    case lists:nth(Level, Acc) of
        undefined -> 
            largestValues(Tree#node.left, Level + 1, [Tree#node.value | Acc]);
        _ -> 
            largestValues(Tree#node.left, Level + 1, 
                lists:map(fun(X) -> max(X, Tree#node.value) end, Acc))
    end.

largestValues([], _) -> [];
largestValues([H | T], Level) ->
    Max = largestValues(H, Level, []),
    Max ++ largestValues(T, Level).