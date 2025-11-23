-module(solution).
-export([distance_k/2]).

-record(tree, {val, left, right}).

distance_k(Root, K) ->
    Path = find_path(Root, K),
    lists:foldl(fun(Node, Acc) -> [Node | Acc] end, [], Path).

find_path(Root, K) ->
    find_path(Root, K, []).

find_path(_, 0, Path) ->
    [lists:last(Path)];
find_path(null, _, _) ->
    [];
find_path(Root, K, Path) ->
    Current = Root#tree.val,
    NewPath = [Current | Path],
    Left = find_path(Root#tree.left, K - 1, NewPath),
    Right = find_path(Root#tree.right, K - 1, NewPath),
    Left ++ Right.