-module(solution).
-export([countPalindromicSubsequences/1]).

countPalindromicSubsequences(S) ->
    lists:sum([
        calculate_for_char(C, S) || C <- lists:seq($a, $z)
    ]).

calculate_for_char(Char, S) ->
    FirstIdx = find_first(Char, S),
    LastIdx = find_last(Char, S),

    if
        FirstIdx == -1 orelse FirstIdx == LastIdx ->
            0;
        true ->
            Sublist = lists:sublist(S, FirstIdx + 2, LastIdx - FirstIdx - 1),
            sets:size(sets:from_list(Sublist))
    end.

find_first(Char, Str) -> find_first(Char, Str, 0).
find_first(Char, [Char|_], Index) -> Index;
find_first(Char, [_|T], Index) -> find_first(Char, T, Index + 1);
find_first(_, [], _) -> -1.

find_last(Char, Str) -> find_last(Char, Str, 0, -1).
find_last(Char, [H|T], Index, AccLast) when H == Char ->
    find_last(Char, T, Index + 1, Index);
find_last(Char, [_|T], Index, AccLast) ->
    find_last(Char, T, Index + 1, AccLast);
find_last(_, [], _, AccLast) -> AccLast.