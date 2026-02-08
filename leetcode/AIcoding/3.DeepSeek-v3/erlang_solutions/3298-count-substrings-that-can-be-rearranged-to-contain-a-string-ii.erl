-module(solution).
-export([count_substrings/2]).

count_substrings(S, T) ->
    SList = binary_to_list(S),
    TList = binary_to_list(T),
    LenT = length(TList),
    LenS = length(SList),
    if
        LenT > LenS -> 0;
        true ->
            TargetFreq = lists:sort(freq(TList, #{})),
            count(SList, TargetFreq, LenT, 0, 0)
    end.

freq([], FreqMap) -> FreqMap;
freq([H|T], FreqMap) ->
    NewFreqMap = maps:update_with(H, fun(V) -> V + 1 end, 1, FreqMap),
    freq(T, NewFreqMap).

count(S, TargetFreq, LenT, Start, Acc) ->
    case Start + LenT > length(S) of
        true -> Acc;
        false ->
            Substring = lists:sublist(S, Start + 1, LenT),
            SubFreq = lists:sort(freq(Substring, #{})),
            case SubFreq == TargetFreq of
                true -> count(S, TargetFreq, LenT, Start + 1, Acc + 1);
                false -> count(S, TargetFreq, LenT, Start + 1, Acc)
            end
    end.