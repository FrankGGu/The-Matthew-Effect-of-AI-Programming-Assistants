-module(find_chalk_student).
-export([chalk_replacer/2]).

chalk_replacer(Chalk, K) ->
  chalk_replacer(Chalk, K, 0, length(Chalk)).

chalk_replacer(Chalk, K, Index, Length) ->
  case K - lists:nth(Index + 1, Chalk) >= 0 of
    true ->
      chalk_replacer(Chalk, K - lists:nth(Index + 1, Chalk), (Index + 1) rem Length, Length);
    false ->
      Index
  end.