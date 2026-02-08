-module(evaluate).
-export([convert_to_title/1]).

convert_to_title(N) ->
    convert_to_title(N, []).

convert_to_title(0, Acc) ->
    lists:reverse(Acc);
convert_to_title(N, Acc) ->
    N1 = N - 1,
    Char = $A + (N1 rem 26),
    convert_to_title(N1 div 26, [Char | Acc]).