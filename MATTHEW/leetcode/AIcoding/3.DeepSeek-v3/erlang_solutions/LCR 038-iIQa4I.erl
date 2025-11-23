-spec daily_temperatures(Temperatures :: [integer()]) -> [integer()].
daily_temperatures(Temperatures) ->
    Stack = [],
    Result = lists:duplicate(length(Temperatures), 0),
    {_, FinalResult} = lists:foldl(fun(Temp, {Index, {CurrentStack, CurrentResult}}) ->
        NewStack = case CurrentStack of
            [] -> [];
            [{PrevTemp, PrevIndex} | Rest] when Temp =< PrevTemp -> CurrentStack;
            _ -> 
                {NewStack1, NewResult} = pop_until_warmer(Temp, Index, CurrentStack, CurrentResult),
                NewStack1
        end,
        {Index + 1, {[{Temp, Index} | NewStack], CurrentResult}}
    end, {0, {Stack, Result}}, Temperatures),
    FinalResult.

pop_until_warmer(Temp, Index, Stack, Result) ->
    case Stack of
        [] -> {[], Result};
        [{PrevTemp, PrevIndex} | Rest] when Temp > PrevTemp ->
            NewResult = setelement(PrevIndex + 1, Result, Index - PrevIndex),
            pop_until_warmer(Temp, Index, Rest, NewResult);
        _ -> {Stack, Result}
    end.