-spec calculate(S :: unicode:unicode_binary()) -> integer().
calculate(S) ->
    calculate(S, 0, 0, 1).

calculate([], Result, _, _) -> Result;
calculate([H | T], Result, PrevNum, Sign) when H =:= $+ orelse H =:= $- ->
    NewSign = case H of
                 $+ -> 1;
                 $- -> -1
               end,
    calculate(T, Result, PrevNum, NewSign);
calculate([H | T], Result, PrevNum, Sign) when H >= $0, H =< $9 ->
    calculate_number([H | T], Result, PrevNum, Sign, 0);
calculate([H | T], Result, PrevNum, Sign) when H =:= $\s ->
    calculate(T, Result, PrevNum, Sign);
calculate([H | T], Result, PrevNum, Sign) when H =:= $('(') ->
    {SubExpr, Rest} = parse_subexpression(T),
    calculate(Rest, Result + SubExpr * Sign, PrevNum, Sign);
calculate([H | T], Result, PrevNum, Sign) when H =:= $')' ->
    Result.

calculate_number([H | T], Result, PrevNum, Sign, Temp) when H >= $0, H =< $9 ->
    calculate_number(T, Result, PrevNum, Sign, Temp * 10 + (H - $0));
calculate_number(T, Result, PrevNum, Sign, Temp) ->
    calculate(T, Result + Temp * Sign, Temp, Sign).
    
parse_subexpression([H | T]) when H =:= $('(') ->
    {SubResult, Rest} = calculate(T),
    {SubResult, Rest}.
