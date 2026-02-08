-module(solution).
-export([next_greater_node/1]).

next_greater_node(Head) ->
    List = to_list(Head),
    Length = length(List),
    Result = lists:seq(1, Length),
    next_greater_node(List, Result, 1, []).

next_greater_node([], _, _, Acc) ->
    lists:reverse(Acc);
next_greater_node([H | T], Result, Index, Acc) ->
    NextGreater = find_next_greater(H, T, 0),
    next_greater_node(T, Result, Index + 1, [NextGreater | Acc]).

find_next_greater(_, [], Default) ->
    Default;
find_next_greater(Value, [H | T], Index) ->
    if
        H > Value -> Index;
        true -> find_next_greater(Value, T, Index + 1)
    end.

to_list(nil) ->
    [];
to_list({node, Val, Next}) ->
    [Val | to_list(Next)].