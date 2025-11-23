-module(solution).
-export([new/1, get_random/1]).

-record(list_node, {val, next}).

new(Head) ->
    Head.

get_random(Head) ->
    get_random_rs(Head, null, 0).

get_random_rs(null, Result, _Count) ->
    Result;
get_random_rs(#list_node{val = Val, next = Next}, CurrentResult, Count) ->
    NewCount = Count + 1,
    R = rand:uniform(NewCount),
    NewResult = case R of
                    1 -> Val;
                    _ -> CurrentResult
                end,
    get_random_rs(Next, NewResult, NewCount).