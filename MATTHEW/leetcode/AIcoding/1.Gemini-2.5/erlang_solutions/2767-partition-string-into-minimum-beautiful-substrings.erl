-module(solution).
-export([partition_string/1]).

-define(INF, 1000000).

-define(BEAUTIFUL_STRINGS, ["1", "101", "11001", "1111101", "1001110001", "110000110101", "11110100001001"]).

partition_string(S) ->
    N = length(S),
    ets:new(memo, [set, public, named_table]),

    Result = solve(S, 0, N),

    ets:delete(memo),

    if Result >= ?INF -> -1;
       true -> Result
    end.

solve(S, Index, N) ->
    if Index == N -> 0;
       true ->
            case ets:lookup(memo, Index) of
                [{Index, Val}] -> Val;
                [] ->
                    if lists:nth(Index + 1, S) == $0 ->
                        ets:insert(memo, {Index, ?INF}),
                        ?INF;
                    else
                        MinPartitions = calculate_min_partitions(S, Index, N),
                        ets:insert(memo, {Index, MinPartitions}),
                        MinPartitions
                    end
            end
    end.

calculate_min_partitions(S, StartIndex, N) ->
    Min = ?INF,
    calculate_min_loop(S, StartIndex, StartIndex, N, Min).

calculate_min_loop(_S, _StartIndex, CurrentEnd, N, AccMin) when CurrentEnd == N ->
    AccMin;
calculate_min_loop(S, StartIndex, CurrentEnd, N, AccMin) ->
    Len = CurrentEnd - StartIndex + 1,
    Sub = lists:sublist(S, StartIndex + 1, Len),

    NewMin = 
        if lists:member(Sub, ?BEAUTIFUL_STRINGS) ->
            RemainingPartitions = solve(S, CurrentEnd + 1, N),
            min(AccMin, 1 + RemainingPartitions);
        else
            AccMin
        end,

    calculate_min_loop(S, StartIndex, CurrentEnd + 1, N, NewMin).