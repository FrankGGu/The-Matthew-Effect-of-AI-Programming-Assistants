-module(p2559).
-export([put_marbles/2]).

put_marbles(Marbles, K) ->
    put_marbles(Marbles, K, 0, 0).

put_marbles([], _, _, Result) ->
    Result;
put_marbles([H | T], K, Count, Result) ->
    if
        Count == K - 1 ->
            put_marbles(T, K, Count + 1, Result + H);
        true ->
            put_marbles(T, K, Count + 1, Result)
    end.