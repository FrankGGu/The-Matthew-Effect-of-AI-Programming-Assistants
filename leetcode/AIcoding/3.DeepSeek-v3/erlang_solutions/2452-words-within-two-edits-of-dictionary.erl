-module(words_within_two_edits).
-export([two_edit_words/2]).

two_edit_words(Queries, Dictionary) ->
    lists:filter(fun(Query) -> is_within_two_edits(Query, Dictionary) end, Queries).

is_within_two_edits(Query, Dictionary) ->
    lists:any(fun(DictWord) -> edit_distance(Query, DictWord) =< 2 end, Dictionary).

edit_distance([], []) -> 0;
edit_distance([], _) -> length(_);
edit_distance(_, []) -> length(_);
edit_distance([H1|T1], [H2|T2]) when H1 =:= H2 ->
    edit_distance(T1, T2);
edit_distance([_|T1], [_|T2]) ->
    1 + edit_distance(T1, T2).