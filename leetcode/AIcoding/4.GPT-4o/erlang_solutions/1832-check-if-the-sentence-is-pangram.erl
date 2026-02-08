-module(solution).
-export([check_if_pangram/1]).

check_if_pangram(Sentence) ->
    Letters = lists:usort(lists:filter(fun(C) -> C >= $a, Sentence end)),
    Length = length(Letters),
    Length =:= 26.