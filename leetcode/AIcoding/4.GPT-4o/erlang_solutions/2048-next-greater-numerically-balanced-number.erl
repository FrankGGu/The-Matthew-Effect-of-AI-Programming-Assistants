-module(solution).
-export([next_greater_balanced/1]).

next_greater_balanced(N) ->
    Next = N + 1,
    case is_balanced(Next) of
        true -> Next;
        false -> next_greater_balanced(Next)
    end.

is_balanced(N) ->
    Digits = integer_to_list(N),
    OddDigits = lists:filter(fun(X) -> (X rem 2) =:= 1 end, Digits),
    EvenDigits = lists:filter(fun(X) -> (X rem 2) =:= 0 end, Digits),
    length(OddDigits) =:= length(EvenDigits).