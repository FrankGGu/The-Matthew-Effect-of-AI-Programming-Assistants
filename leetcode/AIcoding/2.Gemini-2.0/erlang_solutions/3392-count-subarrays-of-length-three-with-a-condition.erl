-module(solution).
-export([count_good_subarrays/2]).

count_good_subarrays(Arr, Thresh) ->
    count_good_subarrays(Arr, Thresh, 0, 0).

count_good_subarrays([], _, Acc, _) ->
    Acc;
count_good_subarrays([A,B,C | Rest], Thresh, Acc, Index) ->
    case (A + B + C) < Thresh orelse A > Thresh orelse B > Thresh orelse C > Thresh of
        true ->
            count_good_subarrays(Rest, Thresh, Acc, Index + 1);
        false ->
            count_good_subarrays(Rest, Thresh, Acc + 1, Index + 1);
    end;
count_good_subarrays(_, _, Acc, _) ->
    Acc.