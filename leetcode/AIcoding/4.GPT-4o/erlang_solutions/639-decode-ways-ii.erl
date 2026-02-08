-module(solution).
-export([num_decodings/1]).

num_decodings(S) ->
    N = length(S),
    num_decodings(S, N, 0, 1, 1).

num_decodings(_, 0, _, Prev, _) -> 
    Prev;
num_decodings(S, N, I, Prev, Count) ->
    Current = list_to_integer(string:substr(S, I, 1)),
    Next = if 
        I < N -> list_to_integer(string:substr(S, I + 1, 1)); 
        true -> 0 
    end,
    NewCount = if 
        Current =:= 0 -> 0; 
        Current =< 9 -> Prev; 
        Current > 9, Current =< 26 -> Prev; 
        true -> 0 
    end,
    NewCount2 = if 
        Current =:= 1 -> Prev; 
        Current =:= 2, Next =< 6 -> Prev; 
        true -> 0 
    end,
    num_decodings(S, N - 1, I + 1, (Count + NewCount) rem 1000000007, NewCount2).