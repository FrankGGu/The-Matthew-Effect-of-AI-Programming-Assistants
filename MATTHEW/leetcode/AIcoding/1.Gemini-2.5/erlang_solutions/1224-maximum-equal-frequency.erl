-spec max_equal_freq(Nums :: [integer()]) -> integer().
max_equal_freq(Nums) ->
    max_equal_freq_loop(Nums, 0, #{}, #{}, 0).

max_equal_freq_loop([], _CurrentPrefixLength, _Counts, _FreqCounts, MaxValidPrefixLength) ->
    MaxValidPrefixLength;
max_equal_freq_loop([Num | Rest], CurrentPrefixLength, Counts, FreqCounts, MaxValidPrefixLength) ->
    NewCurrentPrefixLength = CurrentPrefixLength + 1,

    OldFreq = maps:get(Num, Counts, 0),
    NewFreq = OldFreq + 1,
    NewCounts = maps:put(Num, NewFreq, Counts),

    UpdatedFreqCounts1 =
        if OldFreq > 0 ->
            OldFreqCount = maps:get(OldFreq, FreqCounts);
           true -> 0
        end,

    UpdatedFreqCounts2 =
        if OldFreq > 0 ->
            if UpdatedFreqCounts1 == 1 -> maps:remove(OldFreq, FreqCounts);
               true -> maps:put(OldFreq, UpdatedFreqCounts1 - 1, FreqCounts)
            end;
        true -> FreqCounts
        end,

    NewFreqCount = maps:get(NewFreq, UpdatedFreqCounts2, 0),
    NewFreqCounts = maps:put(NewFreq, NewFreqCount + 1, UpdatedFreqCounts2),

    UpdatedMaxValidPrefixLength =
        if is_valid(NewFreqCounts) -> NewCurrentPrefixLength;
           true -> MaxValidPrefixLength
        end,

    max_equal_freq_loop(Rest, NewCurrentPrefixLength, NewCounts, NewFreqCounts, UpdatedMaxValidPrefixLength).

is_valid(FreqCounts) ->
    Size = maps:size(FreqCounts),
    if Size == 1 ->
        case maps:to_list(FreqCounts) of
            [{Freq, Count}] ->
                Freq == 1 orelse Count == 1
        end;
       Size == 2 ->
        case maps:to_list(FreqCounts) of
            [{F1, N1}, {F2, N2}] ->
                (F1 == 1 and N1 == 1) orelse (F2 == 1 and N2 == 1) orelse
                (F1 == F2 + 1 and N1 == 1) orelse (F2 == F1 + 1 and N2 == 1);
            _ -> false
        end;
       true -> false
    end.