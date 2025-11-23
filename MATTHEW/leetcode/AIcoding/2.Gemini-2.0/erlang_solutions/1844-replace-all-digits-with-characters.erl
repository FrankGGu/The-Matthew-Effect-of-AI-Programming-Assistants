-module(replace_digits).
-export([replace_digits/1]).

replace_digits(S) ->
  replace_digits_helper(S, []).

replace_digits_helper([], Acc) ->
  lists:reverse(Acc);
replace_digits_helper([C], Acc) ->
  lists:reverse([C | Acc]);
replace_digits_helper([C1, C2 | Rest], Acc) when is_integer(C2 - $0) ->
  NewChar = C1 + (C2 - $0),
  replace_digits_helper(Rest, [NewChar | Acc]);
replace_digits_helper([C1, C2 | Rest], Acc) ->
  replace_digits_helper([C2 | Rest], [C1 | Acc]).