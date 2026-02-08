-module(beautiful_towers_i).
-export([max_number_of_beautiful_towers/1]).

max_number_of_beautiful_towers(Height) ->
    N = length(Height),
    Left = lists:seq(0, N-1),
    Right = lists:reverse(lists:seq(0, N-1)),
    MaxLeft = max_left(Height, Left, 0, []),
    MaxRight = max_right(Height, Right, 0, []),
    lists:map(fun(I) -> max(MaxLeft!!I, MaxRight!!I) end, lists:seq(0, N-1)).

max_left(_, [], _, Acc) -> Acc;
max_left(Height, [I | Rest], CurrentMax, Acc) ->
    NewMax = if Height!!I > CurrentMax -> Height!!I; true -> CurrentMax end,
    max_left(Height, Rest, NewMax, [NewMax | Acc]).

max_right(_, [], _, Acc) -> Acc;
max_right(Height, [I | Rest], CurrentMax, Acc) ->
    NewMax = if Height!!I > CurrentMax -> Height!!I; true -> CurrentMax end,
    max_right(Height, Rest, NewMax, [NewMax | Acc]).