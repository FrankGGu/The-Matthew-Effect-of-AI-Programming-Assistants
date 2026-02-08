-module(count_sorted_vowel_strings).
-export([countVowelStrings/1]).

countVowelStrings(N) ->
  countVowelStringsHelper(N, 5).

countVowelStringsHelper(0, _) -> 1;
countVowelStringsHelper(N, 0) -> 0;
countVowelStringsHelper(N, K) ->
  countVowelStringsHelper(N - 1, K) + countVowelStringsHelper(N, K - 1).