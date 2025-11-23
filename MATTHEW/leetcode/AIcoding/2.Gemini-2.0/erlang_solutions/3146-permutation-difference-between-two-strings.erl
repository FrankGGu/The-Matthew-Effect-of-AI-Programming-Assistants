-module(permutation_difference).
-export([permutation_difference/2]).

permutation_difference(S1, S2) ->
  N1 = length(S1),
  N2 = length(S2),
  if N1 /= N2 then
    -1
  else
    Diff = lists:foldl(
             fun(Char, Acc) ->
               Val1 = lists:nth(Char - $a + 1, frequency_map(S1)),
               Val2 = lists:nth(Char - $a + 1, frequency_map(S2)),
               Acc + abs(Val1 - Val2)
             end,
             0,
             lists:seq($a, $z)
           ),
    Diff div 2
  end.

frequency_map(S) ->
  lists:foldl(
    fun(Char, Acc) ->
      Index = Char - $a + 1,
      lists:replace(Index, lists:nth(Index, Acc) + 1, Acc)
    end,
    lists:duplicate(26, 0),
    S
  ).