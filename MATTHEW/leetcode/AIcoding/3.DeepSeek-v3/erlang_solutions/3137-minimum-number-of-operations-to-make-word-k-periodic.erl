-module(solution).
-export([minimum_operations_to_k_periodic/2]).

minimum_operations_to_k_periodic(Word, K) ->
    N = length(Word),
    MaxFreq = lists:foldl(
        fun(I, Max) ->
            Freq = count_freq(Word, I, K, N),
            max(Max, Freq)
        end,
        0,
        lists:seq(1, K)
    ),
    N - MaxFreq.

count_freq(Word, Start, K, N) ->
    Freq = maps:new(),
    lists:foldl(
        fun(I, Map) ->
            Pos = Start + (I - 1) * K,
            if
                Pos > N -> Map;
                true ->
                    Char = lists:nth(Pos, Word),
                    maps:update_with(Char, fun(V) -> V + 1 end, 1, Map)
            end
        end,
        Freq,
        lists:seq(1, (N - Start) div K + 1)
    ),
    case maps:size(Freq) of
        0 -> 0;
        _ -> lists:max(maps:values(Freq))
    end.