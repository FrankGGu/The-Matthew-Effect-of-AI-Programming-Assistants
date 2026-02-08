-module(solution).
-export([solve/2]).

solve(S, K) ->
    count_exactly_k_distinct(S, K).

count_exactly_k_distinct(S, K) ->
    case K of
        0 -> 0;
        _ ->
            count_at_most_k_distinct(S, K) - count_at_most_k_distinct(S, K - 1)
    end.

count_at_most_k_distinct(S, K) ->
    N = length(S),
    count_at_most_k_distinct_loop(S, K, 0, 0, N, maps:new(), 0, 0).

count_at_most_k_distinct_loop(S, K, Left, Right, N, FreqMap, DistinctCount, TotalCount) ->
    if
        Right == N ->
            TotalCount;
        true ->
            CharR = lists:nth(Right + 1, S),

            CurrentCharCount = maps:get(CharR, FreqMap, 0),
            NewFreqMap1 = maps:put(CharR, CurrentCharCount + 1, FreqMap),
            NewDistinctCount1 =
                if
                    CurrentCharCount == 0 -> DistinctCount + 1;
                    true -> DistinctCount
                end,

            {NewLeft, NewFreqMap2, NewDistinctCount2} =
                ensure_k_distinct(S, K, Left, Right, NewFreqMap1, NewDistinctCount1),

            NewTotalCount = TotalCount + (Right - NewLeft + 1),

            count_at_most_k_distinct_loop(S, K, NewLeft, Right + 1, N, NewFreqMap2, NewDistinctCount2, NewTotalCount)
    end.

ensure_k_distinct(S, K, Left, Right, FreqMap, DistinctCount) ->
    if
        DistinctCount > K ->
            CharL = lists:nth(Left + 1, S),

            CharLCount = maps:get(CharL, FreqMap, 0),
            NewFreqMap = maps:put(CharL, CharLCount - 1, FreqMap),
            NewDistinctCount =
                if
                    CharLCount - 1 == 0 -> DistinctCount - 1;
                    true -> DistinctCount
                end,
            ensure_k_distinct(S, K, Left + 1, Right, NewFreqMap, NewDistinctCount);
        true ->
            {Left, FreqMap, DistinctCount}
    end.