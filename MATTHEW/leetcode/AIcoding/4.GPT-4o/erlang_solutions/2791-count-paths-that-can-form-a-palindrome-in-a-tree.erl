-module(solution).
-export([count_palindrome_paths/1]).

-type tree() :: {empty} | {Node, tree(), tree()}.
-type state() :: {map(), integer()}.

count_palindrome_paths(Tree) ->
    {Count, _} = count_paths(Tree, #{}, 0),
    Count.

count_paths(empty, CountMap, Paths) ->
    {Paths div 2, CountMap};
count_paths({Node, Left, Right}, CountMap, Paths) ->
    NewCountMap = maps:update_with(Node, fun(X) -> X + 1 end, 1, CountMap),
    NewPaths = Paths + 1,
    {LeftPaths, LeftCountMap} = count_paths(Left, NewCountMap, NewPaths),
    {RightPaths, RightCountMap} = count_paths(Right, LeftCountMap, NewPaths),
    TotalPaths = LeftPaths + RightPaths,
    {TotalPaths + count_palindrome_paths_helper(NewCountMap), RightCountMap}.

count_palindrome_paths_helper(CountMap) ->
    OddCount = maps:fold(fun(_, V, Acc) -> Acc + (V rem 2) end, 0, CountMap),
    if
        OddCount > 1 -> 0;
        true -> 1
    end.