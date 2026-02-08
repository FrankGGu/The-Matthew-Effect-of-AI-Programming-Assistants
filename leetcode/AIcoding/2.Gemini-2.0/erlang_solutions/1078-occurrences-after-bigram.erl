-module(occurrences_after_bigram).
-export([find_occurrences/3]).

find_occurrences(Text, First, Second) ->
  Words = string:tokens(Text, " "),
  find_occurrences_helper(Words, First, Second, []).

find_occurrences_helper([First, Second, Third | Rest], First, Second, Acc) ->
  find_occurrences_helper([Second, Third | Rest], First, Second, [Third | Acc]);
find_occurrences_helper([_, Second, Third | Rest], First, Second, Acc) ->
  find_occurrences_helper([Second, Third | Rest], First, Second, Acc);
find_occurrences_helper([_ | Rest], First, Second, Acc) ->
  find_occurrences_helper(Rest, First, Second, Acc);
find_occurrences_helper([], _, _, Acc) ->
  lists:reverse(Acc).