-module(solution).
-export([solve/1]).

solve(Bubbles) ->
    process_eliminations(Bubbles).

process_eliminations(Bubbles) ->
    {NewBubbles, Changed} = eliminate_once(Bubbles),
    if
        Changed -> process_eliminations(NewBubbles);
        true -> length(NewBubbles)
    end.

eliminate_once(InputList) ->
    eliminate_once_acc(InputList, [], false).

eliminate_once_acc([], Stack, Changed) ->
    {flatten_stack(Stack), Changed};
eliminate_once_acc([H|T], Stack, ChangedAcc) ->
    case Stack of
        [] ->
            eliminate_once_acc(T, [{H, 1}], ChangedAcc);
        [{TopVal, TopCount}|RestStack] when H == TopVal ->
            if
                TopCount + 1 >= 3 ->
                    eliminate_once_acc(T, RestStack, true);
                true ->
                    eliminate_once_acc(T, [{TopVal, TopCount + 1}|RestStack], ChangedAcc)
            end;
        _ ->
            eliminate_once_acc(T, [{H, 1}|Stack], ChangedAcc)
    end.

flatten_stack(Stack) ->
    flatten_stack(Stack, []).

flatten_stack([], Acc) ->
    Acc;
flatten_stack([{Val, Count}|T], Acc) ->
    NewAcc = append_n_times(Val, Count, Acc),
    flatten_stack(T, NewAcc).

append_n_times(_Val, 0, Acc) -> Acc;
append_n_times(Val, Count, Acc) ->
    append_n_times(Val, Count - 1, [Val|Acc]).