-module(zero_array_transformation_i).
-export([canMakeZero/1]).

canMakeZero(Arr) ->
    canMakeZero(Arr, 0).

canMakeZero([], _) ->
    true;
canMakeZero([H | T], Acc) ->
    case H + Acc of
        Val when Val rem 2 == 0 ->
            canMakeZero(T, Val div 2);
        _ ->
            false
    end.