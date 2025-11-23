-module(solution).
-export([first_letter_to_appear_twice/1]).

first_letter_to_appear_twice(S) ->
    first_letter_to_appear_twice(S, gb_sets:new()).

first_letter_to_appear_twice([H|T], Seen) ->
    case gb_sets:is_element(H, Seen) of
        true ->
            H;
        false ->
            first_letter_to_appear_twice(T, gb_sets:add(H, Seen))
    end.