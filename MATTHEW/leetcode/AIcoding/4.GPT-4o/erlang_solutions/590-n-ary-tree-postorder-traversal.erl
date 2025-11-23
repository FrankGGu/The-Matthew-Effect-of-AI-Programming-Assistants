-module(solution).
-export([postorder/1]).

-type node() :: #node{val :: integer(), children :: [node()]}.
-record(node, {val, children}).

postorder(Root) ->
    postorder_helper(Root, []).

postorder_helper(nil, Acc) ->
    Acc;
postorder_helper(#node{val=Val, children=Children}, Acc) ->
    lists:foldl(fun(Child, Acc0) -> postorder_helper(Child, Acc0) end, Acc, Children),
    [Val | Acc].