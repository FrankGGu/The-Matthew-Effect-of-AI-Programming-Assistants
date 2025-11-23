-module(solution).
-export([kth_largest_perfect_subtree_size/2]).

kth_largest_perfect_subtree_size(Root, K) ->
    {Sizes, _} = traverse(Root, []),
    Sorted = lists:sort(fun(A, B) -> A > B end, Sizes),
    case K =< length(Sorted) of
        true -> lists:nth(K, Sorted);
        false -> -1
    end.

traverse(nil, Acc) -> {[], Acc};
traverse({TreeNode, Left, Right}, Acc) ->
    {LeftSizes, LeftAcc} = traverse(Left, Acc),
    {RightSizes, RightAcc} = traverse(Right, LeftAcc),
    case is_perfect(Left, Right) of
        true ->
            Size = 1 + size(Left) + size(Right),
            {[Size | LeftSizes ++ RightSizes], RightAcc};
        false ->
            {LeftSizes ++ RightSizes, RightAcc}
    end.

is_perfect(nil, nil) -> true;
is_perfect({_, Left1, Right1}, {_, Left2, Right2}) ->
    size(Left1) == size(Right1) andalso size(Left2) == size(Right2) andalso
    size(Left1) == size(Left2);
is_perfect(_, _) -> false.

size(nil) -> 0;
size({_, Left, Right}) -> 1 + size(Left) + size(Right).