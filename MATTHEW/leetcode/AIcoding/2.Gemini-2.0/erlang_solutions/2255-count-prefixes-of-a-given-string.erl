-module(count_prefixes).
-export([count_prefixes/2]).

count_prefixes(Words, S) ->
  count_prefixes(Words, S, 0).

count_prefixes([], _, Acc) ->
  Acc;
count_prefixes([Word | Rest], S, Acc) ->
  case string:starts_with(S, Word) of
    true ->
      count_prefixes(Rest, S, Acc + 1);
    false ->
      count_prefixes(Rest, S, Acc)
  end.