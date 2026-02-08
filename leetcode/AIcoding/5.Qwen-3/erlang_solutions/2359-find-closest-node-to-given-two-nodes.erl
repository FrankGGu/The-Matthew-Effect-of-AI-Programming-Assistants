-module(solution).
-export([closestNode/3]).

closestNode(Root, X, Y) ->
    {XPath, _} = findPath(Root, X, []),
    {YPath, _} = findPath(Root, Y, []),
    findLCA(XPath, YPath).

findPath(nil, _, _) -> {[], false};
findPath(Node, X, Path) ->
    [Val | LeftRight] = binary_to_list(Node),
    [Left, Right] = LeftRight,
    case Val of
        X ->
            {lists:reverse([Val | Path]), true};
        _ ->
            case findPath(Left, X, [Val | Path]) of
                {P, true} -> {P, true};
                _ ->
                    case findPath(Right, X, [Val | Path]) of
                        {P, true} -> {P, true};
                        _ -> {[], false}
                    end
            end
    end.

findLCA([], _) -> [];
findLCA(_, []) -> [];
findLCA([H|T1], [H|T2]) -> [H | findLCA(T1, T2)];
findLCA([_|T1], [_|T2]) -> findLCA(T1, T2).