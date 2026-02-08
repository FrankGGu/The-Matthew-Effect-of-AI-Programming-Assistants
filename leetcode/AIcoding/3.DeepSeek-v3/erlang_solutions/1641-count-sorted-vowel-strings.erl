-spec count_vowel_strings(N :: integer()) -> integer().
count_vowel_strings(N) ->
    count_vowel_strings(N, 5, #{0 => 0}).

count_vowel_strings(0, K, _) -> K;
count_vowel_strings(N, K, Memo) ->
    case maps:get(N, Memo, undefined) of
        undefined ->
            Res = count_vowel_strings(N - 1, K + 1, Memo) + count_vowel_strings(N, K - 1, Memo),
            count_vowel_strings(N, K - 1, Memo#{N => Res});
        Cached -> Cached
    end.