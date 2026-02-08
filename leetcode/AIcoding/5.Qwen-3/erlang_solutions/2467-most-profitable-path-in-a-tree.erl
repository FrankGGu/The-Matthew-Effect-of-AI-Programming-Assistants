-module(most_profitable_path).
-export([countPaths/2]).

countPaths(Root, Alice) ->
    countPaths(Root, Alice, 0).

countPaths(null, _, _) ->
    0;
countPaths({node, Val, Left, Right}, Alice, Depth) ->
    case Val of
        Alice ->
            LeftCount = countPaths(Left, Alice, Depth + 1),
            RightCount = countPaths(Right, Alice, Depth + 1),
            LeftCount + RightCount;
        _ ->
            LeftCount = countPaths(Left, Alice, Depth + 1),
            RightCount = countPaths(Right, Alice, Depth + 1),
            case Depth of
                0 ->
                    LeftCount + RightCount;
                _ ->
                    LeftCount + RightCount + 1
            end
    end.