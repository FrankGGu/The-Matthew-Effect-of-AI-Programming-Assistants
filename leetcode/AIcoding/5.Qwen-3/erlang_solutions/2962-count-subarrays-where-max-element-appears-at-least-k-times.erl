-module(solution).
-export([num_subarrays/1]).

num_subarrays(Nums) ->
    Max = lists:max(Nums),
    count_subarrays(Nums, Max, 0, 0, 0).

count_subarrays([], _, _, _, Acc) ->
    Acc;
count_subarrays([H | T], Max, Count, Left, Acc) ->
    if
        H == Max ->
            NewCount = Count + 1,
            NewAcc = Acc + Left,
            count_subarrays(T, Max, NewCount, Left + 1, NewAcc);
        true ->
            count_subarrays(T, Max, 0, 0, Acc)
    end.