-module(solution).
-export([countMaxOrSubsets/1]).

countMaxOrSubsets(Numbers) ->
    MaxOr = lists:foldl(fun(A, B) -> A bor B end, 0, Numbers),
    countSubsets(Numbers, MaxOr, 0).

countSubsets([], _, CurrentCount) ->
    if CurrentCount > 0 -> 1; true -> 0 end;
countSubsets([H | T], MaxOr, CurrentCount) ->
    NewCount = if (H bor CurrentCount) =:= MaxOr -> CurrentCount + 1; true -> CurrentCount end,
    countSubsets(T, MaxOr, NewCount) + countSubsets(T, MaxOr, CurrentCount).