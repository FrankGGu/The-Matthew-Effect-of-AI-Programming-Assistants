-module(first_unique_character).
-export([first_uniq_char/1]).

first_uniq_char(S) ->
  first_uniq_char(S, 0, []).

first_uniq_char([], _, _) ->
  -1;
first_uniq_char(S, Index, Acc) ->
  Char = lists:nth(1, S),
  Rest = tl(S),
  case lists:member(Char, [C || {C, _} <- Acc]) of
    true ->
      first_uniq_char(Rest, Index + 1, Acc);
    false ->
      case lists:member(Char, Rest) of
        true ->
          first_uniq_char(Rest, Index + 1, [{Char, 2} | Acc]);
        false ->
          Index
      end
  end.