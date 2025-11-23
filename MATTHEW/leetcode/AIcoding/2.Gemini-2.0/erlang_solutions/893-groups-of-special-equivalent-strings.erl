-module(special_equivalent_strings).
-export([num_special_equiv_groups/1]).

num_special_equiv_groups(A) ->
  Len = length(A),
  num_special_equiv_groups(A, Len, []).

num_special_equiv_groups([], 0, Acc) ->
  length(Acc);
num_special_equiv_groups([H|T], Len, Acc) ->
  Sorted = sort_string(H),
  case lists:member(Sorted, Acc) of
    true ->
      num_special_equiv_groups(T, Len - 1, Acc);
    false ->
      num_special_equiv_groups(T, Len - 1, [Sorted|Acc])
  end.

sort_string(S) ->
  {Evens, Odds} = split_string(S, [], []),
  lists:sort(Evens) ++ lists:sort(Odds).

split_string([], Evens, Odds) ->
  {Evens, Odds};
split_string([A,B|Rest], Evens, Odds) ->
  split_string(Rest, [A|Evens], [B|Odds]);
split_string([A], Evens, Odds) ->
  {lists:reverse([A|Evens]), lists:reverse(Odds)}.