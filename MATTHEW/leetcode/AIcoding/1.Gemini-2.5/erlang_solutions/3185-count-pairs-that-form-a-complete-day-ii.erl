-module(solution).
-export([count_pairs/1]).

count_pairs(Hours) ->
    InitialFreqs = lists:duplicate(24, 0),
    Freqs = lists:foldl(
        fun(Hour, AccFreqs) ->
            Remainder = Hour rem 24,
            lists:replace_nth(Remainder + 1, lists:nth(Remainder + 1, AccFreqs) + 1, AccFreqs)
        end,
        InitialFreqs,
        Hours
    ),
    calculate_pairs(Freqs, 0, 0).

calculate_pairs(Freqs, Index, CurrentPairs) when Index < 12 ->
    CountR = lists:nth(Index + 1, Freqs),
    NewPairs =
        case Index of
            0 ->
                CurrentPairs + (CountR * (CountR - 1) div 2);
            _ ->
                CountComplement = lists:nth(24 - Index + 1, Freqs),
                CurrentPairs + (CountR * CountComplement)
        end,
    calculate_pairs(Freqs, Index + 1, NewPairs);
calculate_pairs(Freqs, 12, CurrentPairs) ->
    Count12 = lists:nth(12 + 1, Freqs),
    CurrentPairs + (Count12 * (Count12 - 1) div 2);
calculate_pairs(_Freqs, _Index, CurrentPairs) ->
    CurrentPairs.