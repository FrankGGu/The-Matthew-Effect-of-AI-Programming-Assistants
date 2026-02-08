-module(solution).
-export([punishment_number/1]).

punishment_number(N) ->
    lists:foldl(fun(X, Acc) -> 
        if 
            is_punishment_number(X) -> 
                Acc + X * X; 
            true -> 
                Acc 
        end 
    end, 0, lists:seq(1, N)).

is_punishment_number(X) ->
    S = integer_to_list(X),
    lists:sum(lists:map(fun(C) -> digit_to_integer(C) end, S)) =:= X div 10 + X rem 10.

digit_to_integer(Char) ->
    Char - $0.