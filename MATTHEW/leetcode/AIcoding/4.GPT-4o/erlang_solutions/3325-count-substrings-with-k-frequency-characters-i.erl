-module(solution).
-export([count_k_frequency_substrings/2]).

count_k_frequency_substrings(S, K) ->
    count_k_frequency_substrings(S, K, 0, 0, 0, map:new()).

count_k_frequency_substrings([], _, Count, _, _, _) ->
    Count;
count_k_frequency_substrings([H | T], K, Count, Start, End, Freq) ->
    Freq1 = maps:update_with(H, fun(X) -> X + 1 end, 1, Freq),
    NewCount = if maps:get(H, Freq1) == K -> Count + 1; true -> Count end,
    count_k_frequency_substrings(T, K, NewCount, Start, End + 1, Freq1).

count_k_frequency_substrings(S, K, Count, Start, End, Freq) when Start < End ->
    Count1 = count_k_frequency_substrings(tl(S), K, Count, Start + 1, End, maps:remove(hd(S), Freq)),
    Count1;
count_k_frequency_substrings(S, K, Count, Start, End, Freq) ->
    Count.