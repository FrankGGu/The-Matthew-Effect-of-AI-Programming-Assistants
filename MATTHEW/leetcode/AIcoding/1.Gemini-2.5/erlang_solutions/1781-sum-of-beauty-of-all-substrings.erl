-module(solution).
-export([sum_of_beauty_of_all_substrings/1]).

sum_of_beauty_of_all_substrings(S) ->
    S_list = string:to_list(S),
    N = length(S_list),
    calculate_total_beauty(S_list, N, 0, 0).

calculate_total_beauty(S_list, N, I, Acc) when I < N ->
    InitialFreqs = lists:duplicate(26, 0),
    SubstrFromI = lists:nthtail(I, S_list),
    BeautyForI = calculate_beauty_for_start_pos_optimized(SubstrFromI, N - I, InitialFreqs, 0),
    calculate_total_beauty(S_list, N, I + 1, Acc + BeautyForI);
calculate_total_beauty(_S_list, _N, _I, Acc) ->
    Acc.

calculate_beauty_for_start_pos_optimized(SubstrChars, RemainingLen, Freqs, CurrentBeautyAcc) when RemainingLen > 0 ->
    Char = hd(SubstrChars),
    CharIdx = Char - $a,
    UpdatedFreqs = update_freqs(Freqs, CharIdx),
    Beauty = get_beauty(UpdatedFreqs),
    calculate_beauty_for_start_pos_optimized(tl(SubstrChars), RemainingLen - 1, UpdatedFreqs, CurrentBeautyAcc + Beauty);
calculate_beauty_for_start_pos_optimized(_SubstrChars, _RemainingLen, _Freqs, CurrentBeautyAcc) ->
    CurrentBeautyAcc.

update_freqs(Freqs, CharIdx) ->
    CurrentFreq = lists:nth(CharIdx + 1, Freqs),
    lists:replace_nth(CharIdx + 1, CurrentFreq + 1, Freqs).

get_beauty(Freqs) ->
    MaxFreq = lists:foldl(fun(F, Acc) -> max(F, Acc) end, 0, Freqs),
    MinFreq = lists:foldl(fun(F, Acc) ->
                                  if F > 0 -> min(F, Acc);
                                     true -> Acc
                                  end
                          end, infinity, Freqs),

    if MinFreq == infinity -> 0;
       true -> MaxFreq - MinFreq
    end.