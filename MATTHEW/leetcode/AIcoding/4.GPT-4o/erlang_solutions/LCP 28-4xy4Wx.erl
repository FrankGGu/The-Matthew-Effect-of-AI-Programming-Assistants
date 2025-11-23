-module(solution).
-export([shopping_options/2]).

shopping_options(N, L) ->
    shopping_options(N, L, 0).

shopping_options(N, [], Acc) -> 
    if 
        Acc =:= N -> 1;
        true -> 0 
    end;
shopping_options(N, [{_, P} | Rest], Acc) ->
    shopping_options(N, Rest, Acc) + 
    shopping_options(N, Rest, Acc + P).