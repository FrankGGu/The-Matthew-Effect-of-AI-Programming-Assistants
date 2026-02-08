-spec max_ascending_sum(Nums :: [integer()]) -> integer().
max_ascending_sum(Nums) ->
    max_ascending_sum(Nums, 0, 0, 0).

max_ascending_sum([], _Prev, CurrentSum, MaxSum) ->
    max(CurrentSum, MaxSum);
max_ascending_sum([H | T], Prev, CurrentSum, MaxSum) when H > Prev ->
    max_ascending_sum(T, H, CurrentSum + H, MaxSum);
max_ascending_sum([H | T], _Prev, CurrentSum, MaxSum) ->
    max_ascending_sum(T, H, H, max(CurrentSum, MaxSum)).