-spec daily_temperatures(Temperatures :: [integer()]) -> [integer()].
daily_temperatures(Temperatures) ->
    Stack = [],
    Result = lists:duplicate(length(Temperatures), 0),
    {_, FinalResult} = lists:foldl(fun(Temp, {StackAcc, ResultAcc}) ->
        {NewStack, NewResult} = process_stack(StackAcc, ResultAcc, Temp),
        {[{Temp, length(ResultAcc)} | NewStack], NewResult}
    end, {Stack, Result}, Temperatures),
    FinalResult.

process_stack([], Result, _Temp) ->
    {[], Result};
process_stack([{TopTemp, TopIdx} | Rest], Result, Temp) ->
    case Temp > TopTemp of
        true ->
            NewResult = setelement(TopIdx + 1, Result, length(Result) - TopIdx),
            process_stack(Rest, NewResult, Temp);
        false ->
            {[{TopTemp, TopIdx} | Rest], Result}
    end.