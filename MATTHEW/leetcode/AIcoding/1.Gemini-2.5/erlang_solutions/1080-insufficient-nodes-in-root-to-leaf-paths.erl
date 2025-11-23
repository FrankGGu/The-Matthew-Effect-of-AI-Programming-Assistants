-module(solution).
-export([sufficientSubset/2]).

-record(tree_node, {val, left, right}).

sufficientSubset(Root, Limit) ->
    prune(Root, 0, Limit).

prune(null, _CurrentSum, _Limit) ->
    null;
prune(#tree_node{val = Val, left = Left, right = Right}, CurrentSum, Limit) ->
    NewSum = CurrentSum + Val,
    PrunedLeft = prune(Left, NewSum, Limit),
    PrunedRight = prune(Right, NewSum, Limit),

    if
        PrunedLeft == null andalso PrunedRight == null ->
            if
                NewSum < Limit ->
                    null;
                true -> % NewSum >= Limit
                    #tree_node{val = Val, left = null, right = null}
            end;
        true -> % At least one child is not null
            #tree_node{val = Val, left = PrunedLeft, right = PrunedRight}
    end.