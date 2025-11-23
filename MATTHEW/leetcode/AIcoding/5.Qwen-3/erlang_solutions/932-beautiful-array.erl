-module(beautiful_array).
-export([beautiful_array/1]).

beautiful_array(N) ->
    beautiful_array(N, 1, []).

beautiful_array(0, _, Acc) ->
    lists:reverse(Acc);
beautiful_array(N, Start, Acc) ->
    Mid = (N - 1) div 2,
    Left = beautiful_array(Mid, Start, []),
    Right = beautiful_array(Mid, Start + Mid + 1, []),
    [Start + Mid | Left ++ Right].

beautiful_array(N, Start, Acc) when N == 1 ->
    [Start | Acc];
beautiful_array(N, Start, Acc) ->
    Mid = (N - 1) div 2,
    Left = beautiful_array(Mid, Start, []),
    Right = beautiful_array(Mid, Start + Mid + 1, []),
    [Start + Mid | Left ++ Right].