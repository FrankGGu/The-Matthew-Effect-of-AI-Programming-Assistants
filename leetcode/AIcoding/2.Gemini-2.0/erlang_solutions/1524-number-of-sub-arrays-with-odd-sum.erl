-module(number_of_subarrays_with_odd_sum).
-export([num_of_subarrays/1]).

num_of_subarrays(Arr) ->
    num_of_subarrays(Arr, 0, 0, 0).

num_of_subarrays([], _Even, _Odd, Acc) ->
    Acc;
num_of_subarrays([H|T], Even, Odd, Acc) ->
    case H rem 2 of
        0 ->
            num_of_subarrays(T, Even + 1, Odd, Acc + Odd);
        1 ->
            num_of_subarrays(T, Odd, Even + 1, Acc + Even + 1)
    end.