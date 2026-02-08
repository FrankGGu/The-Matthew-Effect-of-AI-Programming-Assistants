-module(solution).
-export([maximize_number_of_subsequences/2]).

maximize_number_of_subsequences(Text, Pattern) ->
    P0 = hd(Pattern),
    P1 = hd(tl(Pattern)),

    if
        P0 == P1 ->
            Count = count_char_impl(Text, P0, 0),
            Count * (Count + 1) div 2;
        true ->
            InitialCount = count_subsequences_impl(Text, P0, P1, 0, 0),
            CountP0s = count_char_impl(Text, P0, 0),
            CountP1s = count_char_impl(Text, P1, 0),

            Result1 = InitialCount + CountP1s,
            Result2 = InitialCount + CountP0s,

            max(Result1, Result2)
    end.

count_char_impl([], _Char, Acc) ->
    Acc;
count_char_impl([H|T], Char, Acc) when H == Char ->
    count_char_impl(T, Char, Acc + 1);
count_char_impl([_H|T], Char, Acc) ->
    count_char_impl(T, Char, Acc).

count_subsequences_impl([], _P0, _P1, _CurrentP0Count, TotalSubsequences) ->
    TotalSubsequences;
count_subsequences_impl([H|T], P0, P1, CurrentP0Count, TotalSubsequences) when H == P1 ->
    count_subsequences_impl(T, P0, P1, CurrentP0Count, TotalSubsequences + CurrentP0Count);
count_subsequences_impl([H|T], P0, P1, CurrentP0Count, TotalSubsequences) when H == P0 ->
    count_subsequences_impl(T, P0, P1, CurrentP0Count + 1, TotalSubsequences);
count_subsequences_impl([_H|T], P0, P1, CurrentP0Count, TotalSubsequences) ->
    count_subsequences_impl(T, P0, P1, CurrentP0Count, TotalSubsequences).