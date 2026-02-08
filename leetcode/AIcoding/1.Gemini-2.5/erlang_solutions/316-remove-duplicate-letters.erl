-module(solution).
-export([removeDuplicateLetters/1]).

removeDuplicateLetters(S) ->
    CharList = string:to_list(S),
    InitialCounts = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end, #{}, CharList),

    FinalStack = process_chars(CharList, InitialCounts, [], #{}),

    string:from_list(lists:reverse(FinalStack)).

process_chars([], _Counts, Stack, _InStack) ->
    Stack;
process_chars([C|Rest], Counts, Stack, InStack) ->
    CurrentCounts = maps:update_with(C, fun(V) -> V - 1 end, 0, Counts),

    case maps:is_key(C, InStack) of
        true ->
            process_chars(Rest, CurrentCounts, Stack, InStack);
        false ->
            {NewStack, NewInStack} = pop_from_stack(C, CurrentCounts, Stack, InStack),

            UpdatedStack = [C | NewStack],
            UpdatedInStack = maps:put(C, true, NewInStack),

            process_chars(Rest, CurrentCounts, UpdatedStack, UpdatedInStack)
    end.

pop_from_stack(C, Counts, Stack, InStack) ->
    case Stack of
        [] ->
            {[], InStack};
        [Top|RestStack] ->
            if C < Top andalso maps:get(Top, Counts) > 0 ->
                RemovedInStack = maps:remove(Top, InStack),
                pop_from_stack(C, Counts, RestStack, RemovedInStack);
            true ->
                {Stack, InStack}
            end
    end.