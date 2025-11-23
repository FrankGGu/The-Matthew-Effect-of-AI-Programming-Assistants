-module(solution).
-export([minimum_rounds/1]).

-spec minimum_rounds(Tasks :: [integer()]) -> integer().
minimum_rounds(Tasks) ->
    FreqMap = lists:foldl(
        fun(Task, AccMap) ->
            maps:update_with(Task, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        maps:new(),
        Tasks
    ),
    calculate_total_rounds(maps:values(FreqMap), 0).

calculate_total_rounds([], AccRounds) ->
    AccRounds;
calculate_total_rounds([Count | Rest], AccRounds) ->
    if
        Count == 1 ->
            -1;
        true ->
            calculate_total_rounds(Rest, AccRounds + (Count + 2) div 3)
    end.