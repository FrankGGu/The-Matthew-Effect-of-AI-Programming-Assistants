-module(solution).
-export([evaluateTree/1]).

evaluateTree({0}) -> false;
evaluateTree({1}) -> true;
evaluateTree({2, Left, Right}) ->
    evaluateTree(Left) orelse evaluateTree(Right);
evaluateTree({3, Left, Right}) ->
    evaluateTree(Left) andalso evaluateTree(Right).