-module(compare_strings).
-export([num_smaller_by_freq/2]).

num_smaller_by_freq(Str1, Str2) ->
    Freq1 = count_min_char_freq(Str1),
    Freq2 = count_min_char_freq(Str2),
    count_less(Freq1, Freq2).

count_min_char_freq(Str) ->
    MinChar = lists:min(Str),
    Count = lists:foldl(fun(C, Acc) -> if C == MinChar -> Acc + 1; true -> Acc end end, 0, Str),
    Count.

count_less(_, []) -> 0;
count_less(Freq, [H|T]) ->
    if Freq < H -> 1 + count_less(Freq, T);
       true -> count_less(Freq, T)
    end.