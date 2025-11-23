-module(house_robber_iii).
-export([rob/1]).

rob(Root) ->
    {WithRoot, WithoutRoot} = rob_helper(Root),
    max(WithRoot, WithoutRoot).

rob_helper(null) ->
    {0, 0};
rob_helper(Node) ->
    {NodeVal, Left, Right} = Node,
    {LeftWith, LeftWithout} = rob_helper(Left),
    {RightWith, RightWithout} = rob_helper(Right),
    WithRoot = NodeVal + LeftWithout + RightWithout,
    WithoutRoot = max(LeftWith, LeftWithout) + max(RightWith, RightWithout),
    {WithRoot, WithoutRoot}.

max(A, B) ->
    if
        A > B -> A;
        true -> B
    end.