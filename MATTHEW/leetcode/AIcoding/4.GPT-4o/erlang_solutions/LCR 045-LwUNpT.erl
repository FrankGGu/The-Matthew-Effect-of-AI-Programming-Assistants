-module(solution).
-export([findBottomLeftValue/1]).

findBottomLeftValue(Root) ->
    case Root of
        none -> none;
        _ -> findBottomLeftValueHelper([Root], 0)
    end.

findBottomLeftValueHelper([], _) -> none;
findBottomLeftValueHelper(Nodes, Depth) ->
    NextNodes = lists:flatmap(fun(Node) -> 
        case Node of
            {Value, none, none} -> [];
            {Value, Left, none} -> [{Left, Value}];
            {Value, none, Right} -> [{Right, Value}];
            {Value, Left, Right} -> [{Left, Value}, {Right, Value}]
        end
    end, Nodes),
    case NextNodes of
        [] -> hd(lists:map(fun({Value, _}) -> Value end, Nodes));
        _ -> findBottomLeftValueHelper(NextNodes, Depth + 1)
    end.