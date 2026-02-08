-module(solution).
-export([sufficient_nodes/2]).

-record(tree, {val, left = none, right = none}).

sufficient_nodes(Tree, Limit) ->
    Sufficient = sufficient(Tree, Limit, 0),
    lists:filter(fun(X) -> X /= none end, Sufficient).

sufficient(none, _, _) -> [none];
sufficient(#tree{val=Val, left=Left, right=Right}, Limit, Sum) ->
    NewSum = Sum + Val,
    case {Left, Right} of
        {none, none} ->
            if
                NewSum < Limit -> [none];
                true -> [#tree{val=Val, left=Left, right=Right}]
            end;
        {_, _} ->
            LeftNodes = sufficient(Left, Limit, NewSum),
            RightNodes = sufficient(Right, Limit, NewSum),
            case {LeftNodes, RightNodes} of
                {L, R} -> 
                    [#tree{val=Val, left=L, right=R} | lists:filter(fun(X) -> X /= none end, L ++ R)];
            end
    end.