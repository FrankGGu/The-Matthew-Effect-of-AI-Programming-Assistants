-module(edit_distance).
-export([min_distance/2]).

min_distance(Word1, Word2) ->
  D = array:new([], {length(Word1) + 1, length(Word2) + 1}),
  min_distance_helper(Word1, Word2, length(Word1), length(Word2), D).

min_distance_helper(_Word1, _Word2, 0, 0, D) ->
  array:set({0, 0}, 0, D),
  array:get({0, 0}, D);
min_distance_helper(_Word1, _Word2, 0, J, D) ->
  case array:is_defined({0, J}, D) of
    true ->
      array:get({0, J}, D);
    false ->
      Val = min_distance_helper(_Word1, _Word2, 0, J - 1, D) + 1,
      array:set({0, J}, Val, D),
      Val
  end;
min_distance_helper(_Word1, _Word2, I, 0, D) ->
  case array:is_defined({I, 0}, D) of
    true ->
      array:get({I, 0}, D);
    false ->
      Val = min_distance_helper(_Word1, _Word2, I - 1, 0, D) + 1,
      array:set({I, 0}, Val, D),
      Val
  end;
min_distance_helper(Word1, Word2, I, J, D) ->
  case array:is_defined({I, J}, D) of
    true ->
      array:get({I, J}, D);
    false ->
      Cost = if lists:nth(I, Word1) == lists:nth(J, Word2) then 0 else 1 end,
      Val = min([
        min_distance_helper(Word1, Word2, I - 1, J, D) + 1,
        min_distance_helper(Word1, Word2, I, J - 1, D) + 1,
        min_distance_helper(Word1, Word2, I - 1, J - 1, D) + Cost
      ]),
      array:set({I, J}, Val, D),
      Val
  end.