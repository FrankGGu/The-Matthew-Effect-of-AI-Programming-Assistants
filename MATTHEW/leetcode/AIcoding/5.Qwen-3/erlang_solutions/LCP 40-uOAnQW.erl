-module(solution).
-export([calculate/1]).

calculate(Expr) ->
    calculate(Expr, 0, 0, 0, 0).

calculate([], Result, _, _, _) ->
    Result;
calculate([C | Rest], Result, Current, Sign, Parentheses) when C >= $0, C =< $9 ->
    calculate(Rest, Result, Current * 10 + (C - $0), Sign, Parentheses);
calculate([C | Rest], Result, Current, Sign, Parentheses) when C == $+ ->
    calculate(Rest, Result + Sign * Current, 0, 1, Parentheses);
calculate([C | Rest], Result, Current, Sign, Parentheses) when C == $- ->
    calculate(Rest, Result + Sign * Current, 0, -1, Parentheses);
calculate([C | Rest], Result, Current, Sign, Parentheses) when C == $* ->
    calculate(Rest, Result, Current * Sign, 1, Parentheses);
calculate([C | Rest], Result, Current, Sign, Parentheses) when C == $/ ->
    calculate(Rest, Result, Current div Sign, 1, Parentheses);
calculate([$ ( | Rest], Result, Current, Sign, Parentheses) ->
    calculate(Rest, Result, 0, 1, Parentheses + 1);
calculate([$ ) | Rest], Result, Current, Sign, Parentheses) ->
    calculate(Rest, Result + Sign * Current, 0, 1, Parentheses - 1);
calculate([_ | Rest], Result, Current, Sign, Parentheses) ->
    calculate(Rest, Result, 0, 1, Parentheses).

calculate(_, Result, Current, Sign, 0) ->
    Result + Sign * Current.