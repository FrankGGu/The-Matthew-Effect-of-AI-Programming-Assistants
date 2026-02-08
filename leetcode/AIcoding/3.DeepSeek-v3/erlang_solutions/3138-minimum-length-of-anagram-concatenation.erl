-module(solution).
-export([min_anagram_length/1]).

min_anagram_length(S) ->
    Len = length(S),
    lists:min([Gcd || Gcd <- lists:seq(1, Len), Len rem Gcd =:= 0, is_anagram(S, Gcd)]).

is_anagram(S, Gcd) ->
    Len = length(S),
    K = Len div Gcd,
    Sub = lists:sublist(S, Gcd),
    Freq = frequency(Sub),
    lists:all(fun(I) -> 
        Start = (I - 1) * Gcd + 1,
        SubStr = lists:sublist(S, Start, Gcd),
        frequency(SubStr) =:= Freq
    end, lists:seq(1, K)).

frequency(S) ->
    lists:foldl(fun(C, Acc) -> 
        dict:update_counter(C, 1, Acc) 
    end, dict:new(), S).