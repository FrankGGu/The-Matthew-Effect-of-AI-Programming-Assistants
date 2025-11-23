-module(evaluate_boolean_binary_tree).
-export([evaluateTree/1]).

evaluateTree(null) ->
    false;
evaluateTree({Value, null, null}) when Value == 0 ->
    false;
evaluateTree({Value, null, null}) when Value == 1 ->
    true;
evaluateTree({Value, Left, Right}) when Value == 2 ->
    evaluateTree(Left) or evaluateTree(Right);
evaluateTree({Value, Left, Right}) when Value == 3 ->
    evaluateTree(Left) and evaluateTree(Right).