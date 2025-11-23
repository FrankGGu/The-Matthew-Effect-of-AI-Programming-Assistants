-module(solution).

-export([maxDepth/1]).

-record(node, {val, children}).

maxDepth(Root) ->
    case Root of
        null -> 0;
        _ -> maxDepthHelper(Root, 1)
    end.

maxDepthHelper(Root, Depth) ->
    case Root#node.children of
        [] -> Depth;
        Children -> 
            lists:max(lists:map(fun(Child) -> maxDepthHelper(Child, Depth + 1) end, Children))
    end.