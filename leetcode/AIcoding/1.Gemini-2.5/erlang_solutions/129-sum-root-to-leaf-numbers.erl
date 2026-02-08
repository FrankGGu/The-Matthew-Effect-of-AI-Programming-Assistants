-module(solution).
-export([sum_numbers/1]).

-record(treenode, {val, left, right}).

sum_numbers(Root) ->
    dfs(Root, 0).

dfs(nil, _CurrentNumber) ->
    0;
dfs(#'treenode'{val=Val, left=nil, right=nil}, CurrentNumber) ->
    CurrentNumber * 10 + Val;
dfs(#'treenode'{val=Val, left=Left, right=Right}, CurrentNumber) ->
    NewCurrentNumber = CurrentNumber * 10 + Val,
    dfs(Left, NewCurrentNumber) + dfs(Right, NewCurrentNumber).