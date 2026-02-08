-module(contains_duplicate).
-export([contains_duplicate/1]).

contains_duplicate(Nums) ->
  contains_duplicate(Nums, sets:new()).

contains_duplicate([], _Set) ->
  false;
contains_duplicate([H|T], Set) ->
  case sets:is_element(H, Set) of
    true ->
      true;
    false ->
      contains_duplicate(T, sets:add_element(H, Set))
  end.