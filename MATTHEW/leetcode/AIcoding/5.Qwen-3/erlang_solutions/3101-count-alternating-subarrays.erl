-module(count_alternating_subarrays).
-export([countAlternatingSubarrays/1]).

countAlternatingSubarrays(Nums) ->
    countAlternatingSubarrays(Nums, 0, 0, 0).

countAlternatingSubarrays([], _Prev, _Current, Acc) ->
    Acc;
countAlternatingSubarrays([H | T], Prev, Current, Acc) ->
    case Prev of
        H ->
            countAlternatingSubarrays(T, H, 1, Acc + Current);
        _ ->
            countAlternatingSubarrays(T, H, Current + 1, Acc + Current + 1)
    end.