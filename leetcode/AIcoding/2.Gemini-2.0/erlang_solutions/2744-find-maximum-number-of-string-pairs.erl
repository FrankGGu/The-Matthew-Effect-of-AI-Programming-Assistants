-module(find_maximum_number_of_string_pairs).
-export([max_number_of_string_pairs/1]).

max_number_of_string_pairs(Words) ->
    max_number_of_string_pairs(Words, 0).

max_number_of_string_pairs([], Count) ->
    Count;
max_number_of_string_pairs([Word | Rest], Count) ->
    Reversed_Word = lists:reverse(Word),
    case lists:member(Reversed_Word, Rest) of
        true ->
            max_number_of_string_pairs(lists:delete(Reversed_Word, Rest), Count + 1);
        false ->
            max_number_of_string_pairs(Rest, Count)
    end.