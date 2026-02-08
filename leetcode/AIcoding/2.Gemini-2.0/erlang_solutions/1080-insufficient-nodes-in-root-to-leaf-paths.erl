-module(insufficient_nodes).
-export([sufficientSubset/2]).

sufficientSubset(Root, Limit) ->
    {NewRoot, _} = sufficientSubsetHelper(Root, Limit, 0),
    NewRoot.

sufficientSubsetHelper(nil, _Limit, Sum) ->
    {nil, Sum};
sufficientSubsetHelper({Val, Left, Right}, Limit, Sum) ->
    NewSum = Sum + Val,
    {NewLeft, LeftSum} = sufficientSubsetHelper(Left, Limit, NewSum),
    {NewRight, RightSum} = sufficientSubsetHelper(Right, Limit, NewSum),
    case NewLeft == nil and NewRight == nil of
        true ->
            case NewSum >= Limit of
                true ->
                    {{Val, nil, nil}, NewSum};
                false ->
                    {nil, NewSum}
            end;
        false ->
            case NewSum >= Limit orelse LeftSum >= Limit orelse RightSum >= Limit of
                true ->
                    {{Val, NewLeft, NewRight}, NewSum};
                false ->
                    {nil, NewSum}
            end
    end.