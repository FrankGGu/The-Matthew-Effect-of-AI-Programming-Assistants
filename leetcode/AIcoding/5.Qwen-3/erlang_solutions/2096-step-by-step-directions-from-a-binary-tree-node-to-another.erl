-module(solution).
-export([getDirections/2]).

-record(TreeNode, {val, left, right}).

getDirections(Root, startValue, destValue) ->
    PathToStart = findPath(Root, startValue),
    PathToDest = findPath(Root, destValue),
    commonLength = commonPrefixLength(PathToStart, PathToDest),
    UpSteps = lists:duplicate(length(PathToStart) - commonLength, "U"),
    DownSteps = lists:sublist(PathToDest, commonLength + 1, length(PathToDest) - commonLength),
    lists:flatten(UpSteps ++ DownSteps).

findPath(nil, _) -> [];
findPath(#TreeNode{val = Val}, Val) -> [];
findPath(#TreeNode{val = _, left = Left, right = Right}, Val) ->
    case findPath(Left, Val) of
        [] -> 
            case findPath(Right, Val) of
                [] -> [];
                Path -> ["R" ++ Path]
            end;
        Path -> ["L" ++ Path]
    end.

commonPrefixLength([], _) -> 0;
commonPrefixLength(_, []) -> 0;
commonPrefixLength([H1 | T1], [H2 | T2]) when H1 == H2 -> 1 + commonPrefixLength(T1, T2);
commonPrefixLength(_, _) -> 0.