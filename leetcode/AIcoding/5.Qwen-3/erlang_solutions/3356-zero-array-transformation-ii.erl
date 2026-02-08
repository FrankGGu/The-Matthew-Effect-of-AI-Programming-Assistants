-module(zero_array_transformation_ii).
-export([canMakeZero/1]).

canMakeZero(Arr) ->
    canMakeZero(Arr, 0).

canMakeZero([], _) ->
    true;
canMakeZero([H | T], Sum) ->
    NewSum = Sum + H,
    if
        NewSum < 0 ->
            false;
        true ->
            canMakeZero(T, NewSum)
    end.