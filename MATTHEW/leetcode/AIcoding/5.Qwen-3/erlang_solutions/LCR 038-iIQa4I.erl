-module(temperature).  
-export([daily_temperatures/1]).  

daily_temperatures(Temps) ->  
    Len = length(Temps),  
    Result = lists:duplicate(Len, 0),  
    Stack = [],  
    daily_temperatures(Temps, 0, Stack, Result).  

daily_temperatures([], _, _, Result) ->  
    Result;  
daily_temperatures([T | Tails], Index, Stack, Result) ->  
    NewStack = process_stack(Stack, T, Index, Result),  
    daily_temperatures(Tails, Index + 1, NewStack, Result).  

process_stack([], _, _, _) ->  
    [];  
process_stack([{Idx, Temp} | Rest], CurrentTemp, CurrentIndex, Result) ->  
    if  
        CurrentTemp > Temp ->  
            NewResult = lists:sublist(Result, Idx) ++ [CurrentIndex - Idx | lists:nthtail(Idx + 1, Result)],  
            process_stack(Rest, CurrentTemp, CurrentIndex, NewResult);  
        true ->  
            [{Idx, Temp} | Rest]  
    end.