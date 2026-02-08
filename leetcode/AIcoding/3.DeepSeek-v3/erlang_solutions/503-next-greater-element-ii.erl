-spec next_greater_elements(Nums :: [integer()]) -> [integer()].
next_greater_elements(Nums) ->
    N = length(Nums),
    Extended = Nums ++ Nums,
    Stack = [],
    Result = lists:duplicate(2 * N, -1),
    {_, FinalResult} = lists:foldl(fun(I, {StackAcc, ResAcc}) ->
        Num = lists:nth(I + 1, Extended),
        {NewStack, NewRes} = process_stack(StackAcc, ResAcc, I, Num),
        {[I | NewStack], NewRes}
    end, {Stack, Result}, lists:seq(0, 2 * N - 1)),
    lists:sublist(FinalResult, N).

process_stack(Stack, Res, I, Num) ->
    case Stack of
        [] -> {Stack, Res};
        [Top | Rest] ->
            TopNum = lists:nth(Top + 1, Extended),
            if
                Num > TopNum ->
                    NewRes = setelement(Top + 1, Res, Num),
                    process_stack(Rest, NewRes, I, Num);
                true ->
                    {Stack, Res}
            end
    end.