-module(solution).
-compile([export_all]).

-spec longest_substring(S :: unicode:unicode_binary(), K :: integer()) -> integer().
longest_substring(S, K) -> longest_substring(S, K, 0).

longest_substring([], _, MaxLen) -> MaxLen;
longest_substring(S, K, MaxLen) when length(S) < K -> MaxLen;
longest_substring([H | T], K, MaxLen) ->
    {Left, Right} = split_by_char(S, H, K),
    NewLen = max(longest_substring(Left, K, MaxLen), longest_substring(Right, K, MaxLen)),
    NewLen.

split_by_char([], _, _) -> {[], []};
split_by_char([H | T], Char, K) when count_occurrences([H | T], Char) < K -> {[], [H | T]};
split_by_char([H | T], Char, K) when count_occurrences([H | T], Char) >= K -> { [H | Left], Right }.

count_occurrences([], _) -> 0;
count_occurrences([H | T], Char) when H =:= Char -> 1 + count_occurrences(T, Char);
count_occurrences([H | T], Char) -> count_occurrences(T, Char).
