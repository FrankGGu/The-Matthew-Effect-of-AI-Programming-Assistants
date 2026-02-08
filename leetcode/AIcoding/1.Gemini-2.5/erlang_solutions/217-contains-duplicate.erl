-module(solution).
-export([containsDuplicate/1]).

containsDuplicate(Nums) ->
    contains_duplicate_helper(Nums, sets:new()).

contains_duplicate_helper([], _Seen) ->
    false;
contains_duplicate_helper([H|T], Seen) ->
    case sets:is_element(H, Seen) of
        true ->
            true;
        false ->
            contains_duplicate_helper(T, sets:add_element(H, Seen))
    end.