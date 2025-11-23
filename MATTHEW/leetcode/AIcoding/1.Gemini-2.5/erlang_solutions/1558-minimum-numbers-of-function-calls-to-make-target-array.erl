-module(solution).
-export([min_operations/1]).

min_operations(Target) ->
    {TotalIncrements, MaxMultiplies} = lists:foldl(
        fun(N, {AccInc, AccMaxMul}) ->
            process_number(N, AccInc, AccMaxMul, 0)
        end,
        {0, 0},
        Target
    ),
    TotalIncrements + MaxMultiplies.

process_number(0, AccInc, AccMaxMul, CurrentMul) ->
    {AccInc, max(AccMaxMul, CurrentMul)};
process_number(N, AccInc, AccMaxMul, CurrentMul) when N rem 2 == 1 ->
    process_number(N - 1, AccInc + 1, AccMaxMul, CurrentMul);
process_number(N, AccInc, AccMaxMul, CurrentMul) ->
    process_number(N div 2, AccInc, AccMaxMul, CurrentMul + 1).