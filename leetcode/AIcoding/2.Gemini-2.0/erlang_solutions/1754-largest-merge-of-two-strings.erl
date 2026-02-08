-module(largest_merge_of_two_strings).
-export([largestMerge/2]).

largestMerge(Word1, Word2) ->
    largestMerge(Word1, Word2, []).

largestMerge([], [], Acc) ->
    lists:reverse(Acc);
largestMerge([], Word2, Acc) ->
    lists:reverse(Acc) ++ Word2;
largestMerge(Word1, [], Acc) ->
    lists:reverse(Acc) ++ Word1;
largestMerge(Word1, Word2, Acc) ->
    case Word1 >= Word2 of
        true ->
            [H1|T1] = Word1,
            largestMerge(T1, Word2, [H1|Acc]);
        false ->
            [H2|T2] = Word2,
            largestMerge(Word1, T2, [H2|Acc])
    end.