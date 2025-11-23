-module(shuffle_the_array).
-export([shuffle/1]).

shuffle(Numbers) ->
    N = length(Numbers),
    Half = N div 2,
    shuffle(Numbers, Half, []).

shuffle([], _, Acc) ->
    lists:reverse(Acc);
shuffle([X|Xs], Half, Acc) ->
    [Y|Ys] = Xs,
    shuffle(Ys, Half-1, [X,Y | Acc]).