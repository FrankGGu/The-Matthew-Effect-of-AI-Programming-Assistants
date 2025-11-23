-module(increasing_decreasing_string).
-export([sortString/1]).

sortString(S) ->
  sortString_helper(string:to_list(S), []).

sortString_helper([], Acc) ->
  lists:reverse(Acc);
sortString_helper(S, Acc) ->
  {MinChars, Remaining1} = findMinChars(S, []),
  {MaxChars, Remaining2} = findMaxChars(Remaining1, []),
  sortString_helper(Remaining2, Acc ++ MinChars ++ lists:reverse(MaxChars)).

findMinChars([], Acc) ->
  {Acc, []};
findMinChars(S, Acc) ->
  MinChar = lists:min(S),
  MinChars = [C || C <- S, C == MinChar],
  Remaining = [C || C <- S, C /= MinChar],
  {MinChars, Remaining}.

findMaxChars([], Acc) ->
  {Acc, []};
findMaxChars(S, Acc) ->
  MaxChar = lists:max(S),
  MaxChars = [C || C <- S, C == MaxChar],
  Remaining = [C || C <- S, C /= MaxChar],
  {MaxChars, Remaining}.