-module(peaks_in_array).
-export([peaks/1]).

peaks(Nums) ->
    peaks(Nums, 0, []).

peaks([], _, Acc) ->
    lists:reverse(Acc);
peaks([_], _, Acc) ->
    lists:reverse(Acc);
peaks([A, B | Rest], Index, Acc) ->
    case (A > B) of
        true ->
            peaks([B | Rest], Index + 1, [Index | Acc]);
        false ->
            peaks([B | Rest], Index + 1, Acc)
    end.