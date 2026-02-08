-module(solution).
-export([maximum_sum/1]).

maximum_sum(Nums) ->
    max_sum_with_deletion(Nums, 0, -1, 0, 0).

max_sum_with_deletion([], Max, _, _, _) -> Max;
max_sum_with_deletion([H | T], Max, NoDelMax, DelMax, CurrentMax) ->
    NewNoDelMax = max(CurrentMax + H, H),
    NewDelMax = max(NoDelMax + H, DelMax + H),
    NewMax = max(Max, max(NewNoDelMax, NewDelMax)),
    max_sum_with_deletion(T, NewMax, NewNoDelMax, NewDelMax, NewNoDelMax).