-module(solution).
-export([count_symmetric_integers/2]).

count_symmetric_integers(N, M) ->
    lists:foldl(fun(X, Acc) ->
        if 
            is_symmetric(X) -> 
                Acc + 1; 
            true -> 
                Acc 
        end
    end, 0, lists:seq(N, M)).

is_symmetric(X) ->
    Digits = integer_to_list(X),
    Length = length(Digits),
    HalfLength = Length div 2,
    FirstHalf = lists:sublist(Digits, 1, HalfLength),
    SecondHalf = lists:sublist(Digits, Length - HalfLength, HalfLength),
    FirstHalf =:= lists:reverse(SecondHalf).