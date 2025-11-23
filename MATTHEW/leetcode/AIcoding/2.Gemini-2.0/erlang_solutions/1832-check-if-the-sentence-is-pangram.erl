-module(pangram).
-export([check_if_pangram/1]).

check_if_pangram(Sentence) ->
  Letters = sets:from_list([X || X <- Sentence, X >= $a, X <= $z]),
  sets:size(Letters) == 26.