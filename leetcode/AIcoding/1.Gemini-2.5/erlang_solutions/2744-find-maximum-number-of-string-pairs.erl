-module(solution).
-export([maximum_number_of_string_pairs/1]).

maximum_number_of_string_pairs(Words) ->
    maximum_number_of_string_pairs_impl(Words, gb_sets:new(), 0).

maximum_number_of_string_pairs_impl([], _SeenWords, Count) ->
    Count;
maximum_number_of_string_pairs_impl([Word | Rest], SeenWords, Count) ->
    ReversedWord = lists:reverse(Word),
    case gb_sets:is_member(ReversedWord, SeenWords) of
        true ->
            NewSeenWords = gb_sets:delete_element(ReversedWord, SeenWords),
            maximum_number_of_string_pairs_impl(Rest, NewSeenWords, Count + 1);
        false ->
            NewSeenWords = gb_sets:add_element(Word, SeenWords),
            maximum_number_of_string_pairs_impl(Rest, NewSeenWords, Count)
    end.