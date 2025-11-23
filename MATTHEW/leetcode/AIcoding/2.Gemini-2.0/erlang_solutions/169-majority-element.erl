-module(majority_element).
-export([majority_element/1]).

majority_element(Nums) ->
  majority_element(Nums, 0, 0).

majority_element([], Candidate, Count) ->
  Candidate;
majority_element([H|T], Candidate, Count) ->
  if
    Count == 0 ->
      majority_element(T, H, 1);
    H == Candidate ->
      majority_element(T, Candidate, Count + 1);
    true ->
      majority_element(T, Candidate, Count - 1)
  end.