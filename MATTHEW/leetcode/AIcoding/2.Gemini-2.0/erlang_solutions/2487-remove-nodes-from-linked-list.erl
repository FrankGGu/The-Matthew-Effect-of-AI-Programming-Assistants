-module(solution).
-export([removeNodes/1]).

removeNodes(Head) ->
    reverse(helper(reverse(Head), 0)).

helper([], Max) ->
    [];
helper([{Val, _} | T], Max) ->
    if
        Val >= Max ->
            [{Val, _} | helper(T, Val)];
        true ->
            helper(T, Max)
    end.

reverse(L) ->
    reverse(L, []).

reverse([], Acc) ->
    Acc;
reverse([{H1,H2} | T], Acc) ->
    reverse(T, [{H1,H2} | Acc]).