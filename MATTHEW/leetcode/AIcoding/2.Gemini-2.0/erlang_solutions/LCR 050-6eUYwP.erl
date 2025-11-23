-module(path_sum_iii).
-export([path_sum/2]).

path_sum(Root, Sum) ->
    path_sum_helper(Root, Sum, []).

path_sum_helper(null, _, _) ->
    0;
path_sum_helper(Node, Sum, Path) ->
    Val = Node#tree.val,
    NewPath = [0 | Path],
    NewPath2 = lists:map(fun(X) -> X + Val end, NewPath),
    Count = lists:sum([1 when X == Sum orelse X > Sum -> 0; true -> 1 end, NewPath2]),
    LeftCount = path_sum_helper(Node#tree.left, Sum, NewPath2),
    RightCount = path_sum_helper(Node#tree.right, Sum, NewPath2),
    Count + LeftCount + RightCount.