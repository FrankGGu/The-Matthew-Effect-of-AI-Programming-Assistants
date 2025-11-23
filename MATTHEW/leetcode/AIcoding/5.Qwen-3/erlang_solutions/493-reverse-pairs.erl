-module(reverse_pairs).
-export([reverse_pairs/1]).

reverse_pairs(Nums) ->
    reverse_pairs(Nums, 0, length(Nums) - 1).

reverse_pairs(_, _, L) when L =< 0 -> 0;
reverse_pairs(Nums, Start, End) ->
    Mid = (Start + End) div 2,
    Left = reverse_pairs(Nums, Start, Mid),
    Right = reverse_pairs(Nums, Mid + 1, End),
    Merge = merge(Nums, Start, Mid, End),
    Left + Right + Merge.

merge(Nums, Start, Mid, End) ->
    I = Start,
    J = Mid + 1,
    K = Start,
    Count = 0,
    Temp = lists:seq(1, End - Start + 1),
    merge_loop(Nums, Temp, Start, Mid, End, I, J, K, Count).

merge_loop(_, _, _, _, End, I, J, K, Count) when K > End -> Count;
merge_loop(Nums, Temp, Start, Mid, End, I, J, K, Count) ->
    if
        I > Mid -> 
            lists:put(K, lists:nth(J, Nums), Temp),
            merge_loop(Nums, Temp, Start, Mid, End, I, J + 1, K + 1, Count);
        J > End -> 
            lists:put(K, lists:nth(I, Nums), Temp),
            merge_loop(Nums, Temp, Start, Mid, End, I + 1, J, K + 1, Count);
        lists:nth(I, Nums) <= lists:nth(J, Nums) -> 
            lists:put(K, lists:nth(I, Nums), Temp),
            merge_loop(Nums, Temp, Start, Mid, End, I + 1, J, K + 1, Count);
        true -> 
            Count1 = Count + (Mid - I + 1),
            lists:put(K, lists:nth(J, Nums), Temp),
            merge_loop(Nums, Temp, Start, Mid, End, I, J + 1, K + 1, Count1)
    end.

copy_temp(Nums, Temp, Start, End) ->
    copy_temp(Nums, Temp, Start, End, Start).

copy_temp(_, _, End, End, _) -> ok;
copy_temp(Nums, Temp, Start, End, K) ->
    lists:put(K, lists:nth(K - Start + 1, Temp), Nums),
    copy_temp(Nums, Temp, Start, End, K + 1).