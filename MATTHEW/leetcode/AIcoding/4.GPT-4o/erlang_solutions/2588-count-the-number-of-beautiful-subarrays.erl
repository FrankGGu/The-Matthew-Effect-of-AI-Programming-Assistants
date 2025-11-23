-module(solution).
-export([beautiful_subarrays/1]).

beautiful_subarrays(List) ->
    Count = lists:foldl(fun(X, Acc) -> Acc + X end, 0, List),
    PrefixSums = lists:map(fun(X) -> X rem 2 end, List),
    CountBeautiful(PrefixSums, 0, #{0 => 1}, Count).

CountBeautiful([], _, M, _) -> 
    maps:get(0, M);
CountBeautiful([H | T], Current, M, Total) ->
    NewCurrent = Current + H,
    NewCount = maps:get(NewCurrent, M, 0),
    NewM = maps:update_with(NewCurrent, fun(X) -> X + 1 end, 1, M),
    NewCount + CountBeautiful(T, NewCurrent, NewM, Total).