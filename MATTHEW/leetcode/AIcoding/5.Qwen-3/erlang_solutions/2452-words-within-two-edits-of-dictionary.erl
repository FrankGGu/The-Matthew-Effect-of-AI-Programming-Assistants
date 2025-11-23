-module(solution).
-export([two_edit_words/2]).

two_edit_words(Queries, Dictionary) ->
    lists:filter(fun(Query) -> is_within_two_edits(Query, Dictionary) end, Queries).

is_within_two_edits(Query, Dictionary) ->
    lists:any(fun(DictWord) -> edit_distance(Query, DictWord) =< 2 end, Dictionary).

edit_distance([], []) -> 0;
edit_distance([], _) -> length([]);
edit_distance(_, []) -> length([]);
edit_distance([H1|T1], [H2|T2]) ->
    if
        H1 == H2 -> edit_distance(T1, T2);
        true -> 1 + min(edit_distance(T1, T2), edit_distance(T1, T2), edit_distance([H1|T1], T2))
    end.