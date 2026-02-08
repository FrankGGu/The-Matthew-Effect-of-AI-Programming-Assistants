-spec next_greater_elements(Nums :: [integer()]) -> [integer()].
next_greater_elements(Nums) ->
    N = length(Nums),
    Result = lists:duplicate(N, -1),
    Stack1 = [],
    Stack2 = [],
    {Result1, _, _} = process_stack(Nums, Stack1, Stack2, Result, 0),
    Result1.

process_stack([], Stack1, Stack2, Result, _Index) ->
    {Result, Stack1, Stack2};
process_stack([Num | Rest], Stack1, Stack2, Result, Index) ->
    {NewStack1, NewStack2, NewResult} = process_element(Num, Stack1, Stack2, Result, Index),
    process_stack(Rest, NewStack1, NewStack2, NewResult, Index + 1).

process_element(Num, Stack1, Stack2, Result, Index) ->
    {NewStack1, NewStack2, NewResult} = process_stack2(Num, Stack1, Stack2, Result),
    {[{Num, Index} | NewStack1], NewStack2, NewResult}.

process_stack2(Num, Stack1, [], Result) ->
    {Stack1, [], Result};
process_stack2(Num, Stack1, [{PrevNum, PrevIndex} | RestStack2], Result) ->
    if
        Num > PrevNum ->
            NewResult = setelement(PrevIndex + 1, Result, Num),
            process_stack2(Num, Stack1, RestStack2, NewResult);
        true ->
            {Stack1, [{PrevNum, PrevIndex} | RestStack2], Result}
    end.