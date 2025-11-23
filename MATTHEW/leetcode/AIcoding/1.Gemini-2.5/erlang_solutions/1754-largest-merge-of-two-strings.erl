-module(solution).
-export([largestMerge/2]).

largestMerge(Word1, Word2) ->
    largestMerge_impl(Word1, Word2, []).

largestMerge_impl([], Word2, Acc) ->
    lists:reverse(Acc) ++ Word2;
largestMerge_impl(Word1, [], Acc) ->
    lists:reverse(Acc) ++ Word1;
largestMerge_impl([H1|T1], [H2|T2], Acc) when H1 > H2 ->
    largestMerge_impl(T1, [H2|T2], [H1|Acc]);
largestMerge_impl([H1|T1], [H2|T2], Acc) when H2 > H1 ->
    largestMerge_impl([H1|T1], T2, [H2|Acc]);
largestMerge_impl([H1|T1] = S1, [H2|T2] = S2, Acc) when H1 == H2 ->
    case S1 > S2 of
        true -> largestMerge_impl(T1, S2, [H1|Acc]);
        false -> largestMerge_impl(S1, T2, [H2|Acc])
    end.