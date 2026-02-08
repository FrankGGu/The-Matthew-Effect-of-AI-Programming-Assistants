-module(count_substrings_that_satisfy_k_constraint_ii).
-export([count_substrings/2]).

count_substrings(S, K) ->
  count_substrings_helper(S, K, 0).

count_substrings_helper(S, K, Acc) ->
  Len = length(S),
  count_substrings_helper(S, K, 0, Len, Acc).

count_substrings_helper(_, _, Start, Len, Acc) when Start >= Len ->
  Acc;
count_substrings_helper(S, K, Start, Len, Acc) ->
  count_substrings_helper(S, K, Start, 0, Len, Acc).

count_substrings_helper(_, _, Start, End, Len, Acc) when End > Len ->
  count_substrings_helper(S, K, Start + 1, Len, Acc);
count_substrings_helper(S, K, Start, End, Len, Acc) ->
  Sub = sub_string(S, Start+1, End),
  if is_valid(Sub, K) ->
    count_substrings_helper(S, K, Start, End + 1, Len, Acc + 1);
  true ->
    count_substrings_helper(S, K, Start, End + 1, Len, Acc)
  end.

is_valid(Sub, K) ->
  is_valid_helper(Sub, K, []).

is_valid_helper([], K, Occ) ->
  Len = length(Occ),
  Len =< K;

is_valid_helper([H|T], K, Occ) ->
  Char = erlang:element(1, H),
  if lists:member(Char, Occ) ->
    is_valid_helper(T, K, Occ);
  true ->
    is_valid_helper(T, K, [Char|Occ])
  end.