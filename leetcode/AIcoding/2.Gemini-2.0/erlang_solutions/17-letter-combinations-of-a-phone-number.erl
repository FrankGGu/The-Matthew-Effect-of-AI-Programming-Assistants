-module(letter_combinations).
-export([letter_combinations/1]).

letter_combinations(Digits) ->
  DigitsList = string:to_list(Digits),
  Mappings = #{
    '2' => "abc",
    '3' => "def",
    '4' => "ghi",
    '5' => "jkl",
    '6' => "mno",
    '7' => "pqrs",
    '8' => "tuv",
    '9' => "wxyz"
  },
  do_combinations(DigitsList, Mappings).

do_combinations([], _) ->
  [""];
do_combinations([Digit | Rest], Mappings) ->
  Letters = maps:get(Digit, Mappings, ""),
  RestCombinations = do_combinations(Rest, Mappings),
  [ [Letter | Combination] || Letter <- string:to_list(Letters), Combination <- RestCombinations].