-module(solution).
-export([minimumDeletions/2]).

minimumDeletions(S, K) ->
    FreqMap = count_frequencies(S),
    N = length(S),
    PossibleTargetMinFreqs = lists:seq(0, N),

    lists:foldl(fun(TargetMinFreq, MinDeletionsAcc) ->
        TargetMaxFreq = TargetMinFreq + K,
        CurrentDeletions = calculate_deletions(FreqMap, TargetMinFreq, TargetMaxFreq),
        min(MinDeletionsAcc, CurrentDeletions)
    end, N, PossibleTargetMinFreqs).

count_frequencies(S) ->
    lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
    end, maps:new(), S).

calculate_deletions(FreqMap, TargetMinFreq, TargetMaxFreq) ->
    maps:fold(fun(_Char, Freq, Acc) ->
        if
            Freq < TargetMinFreq ->
                Acc + Freq;
            Freq > TargetMaxFreq ->
                Acc + (Freq - TargetMaxFreq);
            true ->
                Acc
        end
    end, 0, FreqMap).