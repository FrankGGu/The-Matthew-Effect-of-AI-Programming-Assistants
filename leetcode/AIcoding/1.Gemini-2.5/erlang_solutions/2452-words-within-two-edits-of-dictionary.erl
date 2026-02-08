-module(solution).
-export([wordsWithinTwoEdits/2]).

wordsWithinTwoEdits(Queries, Dictionary) ->
    lists:filter(fun(Query) -> is_within_two_edits_of_any(Query, Dictionary) end, Queries).

is_within_two_edits_of_any(Query, Dictionary) ->
    lists:any(fun(DictWord) -> is_within_two_edits(Query, DictWord) end, Dictionary).

is_within_two_edits(Word1, Word2) ->
    case length(Word1) == length(Word2) of
        true ->
            count_diffs(Word1, Word2, 0);
        false ->
            false
    end.

count_diffs([], [], DiffCount) when DiffCount =< 2 -> true;
count_diffs([], [], _) -> false;
count_diffs([H1|T1], [H2|T2], DiffCount) ->
    case H1 == H2 of
        true -> count_diffs(T1, T2, DiffCount);
        false ->
            case DiffCount + 1 =< 2 of
                true -> count_diffs(T1, T2, DiffCount + 1);
                false -> false
            end
    end.