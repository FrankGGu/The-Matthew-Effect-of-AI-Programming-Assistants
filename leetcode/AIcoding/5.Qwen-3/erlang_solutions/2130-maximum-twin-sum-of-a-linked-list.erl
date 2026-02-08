-module(max_twin_sum).
-export([pairSum/1]).

-record(list_node, {val, next}).

pairSum(Head) ->
    List = to_list(Head),
    N = length(List),
    Max = lists:max([lists:nth(I, List) + lists:nth(N - I + 1, List) || I <- lists:seq(1, N div 2)]),
    Max.

to_list(null) -> [];
to_list(#list_node{val = Val, next = Next}) ->
    [Val | to_list(Next)].