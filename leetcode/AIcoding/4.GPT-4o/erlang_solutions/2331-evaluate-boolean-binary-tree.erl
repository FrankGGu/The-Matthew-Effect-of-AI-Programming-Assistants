-module(solution).
-export([evaluate/1]).

-record(node, {val, left = none, right = none}).

evaluate(Tree) ->
    case Tree of
        none -> false;
        #node{val=0, left=Left, right=Right} -> evaluate(Left) orelse evaluate(Right);
        #node{val=1, left=Left, right=Right} -> evaluate(Left) orelse evaluate(Right);
        #node{val=2, left=Left, right=Right} -> evaluate(Left) orelse evaluate(Right);
        _ -> false
    end.