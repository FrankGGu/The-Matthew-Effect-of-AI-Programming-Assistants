-module(solution).
-export([largestCombination/1]).

largestCombination(Candidates) ->
    BitCounts = maps:new(),

    FinalBitCounts = lists:foldl(
        fun(Num, AccBitCounts) ->
            count_set_bits(Num, 0, AccBitCounts)
        end,
        BitCounts,
        Candidates
    ),

    case maps:values(FinalBitCounts) of
        [] -> 0;
        Counts -> lists:max(Counts)
    end.

count_set_bits(N, BitPos, AccMap) when N == 0 ->
    AccMap;
count_set_bits(N, BitPos, AccMap) when BitPos < 24 ->
    NewAccMap = if (N band 1) /= 0 ->
                    maps:update_with(BitPos, fun(Count) -> Count + 1 end, 1, AccMap);
                true ->
                    AccMap
                end,
    count_set_bits(N bsr 1, BitPos + 1, NewAccMap);
count_set_bits(_N, _BitPos, AccMap) ->
    AccMap.