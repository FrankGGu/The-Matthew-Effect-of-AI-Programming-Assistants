-module(count_similar_strings).
-export([count_similar_pairs/1]).

count_similar_pairs(Words) ->
    Len = length(Words),
    count_similar_pairs_helper(Words, 0, Len).

count_similar_pairs_helper([], Acc, _) ->
    Acc;
count_similar_pairs_helper([H|T], Acc, Len) ->
    NewAcc = Acc + count_similar(H, T),
    count_similar_pairs_helper(T, NewAcc, Len).

count_similar(_, []) ->
    0;
count_similar(Word1, [Word2|Rest]) ->
    case is_similar(Word1, Word2) of
        true ->
            1 + count_similar(Word1, Rest);
        false ->
            count_similar(Word1, Rest)
    end.

is_similar(Word1, Word2) ->
    Set1 = string_to_set(Word1),
    Set2 = string_to_set(Word2),
    Set1 == Set2.

string_to_set(String) ->
    string:to_list(String)
    |> lists:sort()
    |> lists:usort().