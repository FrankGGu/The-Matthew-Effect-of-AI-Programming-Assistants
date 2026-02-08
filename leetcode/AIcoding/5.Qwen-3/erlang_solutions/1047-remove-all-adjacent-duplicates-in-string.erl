-module(remove_all_adjacent_duplicates_in_string).
-export([remove_duplicates/1]).

remove_duplicates(Str) ->
    remove_duplicates(Str, []).

remove_duplicates([], Acc) ->
    lists:reverse(Acc);
remove_duplicates([H | T], [H | Acc]) ->
    remove_duplicates(T, Acc);
remove_duplicates([H | T], Acc) ->
    remove_duplicates(T, [H | Acc]).