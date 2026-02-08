-module(solution).
-export([check_pangram/1]).

check_pangram(Sentence) ->
    CharSet = lists:usort([Char || Char <- Sentence, Char >= $a, Char =< $z]),
    length(CharSet) == 26.