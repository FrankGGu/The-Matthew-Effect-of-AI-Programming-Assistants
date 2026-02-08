-module(solution).
-export([sum_numbers/1]).

-record(tree_node, {val=0, left=null, right=null}).

sum_numbers(Root) ->
    dfs(Root, 0).

dfs(null, _CurrentNum) ->
    0;
dfs(#tree_node{val=Val, left=Left, right=Right}, CurrentNum) ->
    NewNum = CurrentNum * 10 + Val,
    case {Left, Right} of
        {null, null} ->
            NewNum;
        _ ->
            dfs(Left, NewNum) + dfs(Right, NewNum)
    end.