-module(solution).
-export([compress/1]).

compress(Str) ->
    compress(Str, [], 0).

compress([], Acc, _) ->
    lists:reverse(Acc);
compress([H | T], Acc, Count) ->
    compress(T, Acc, Count + 1, H, 1).

compress([], Acc, Count, Char, _) ->
    Acc ++ [Char | integer_to_list(Count)];
compress([H | T], Acc, Count, Char, _) when H =:= Char ->
    compress(T, Acc, Count + 1, Char, 1);
compress([H | T], Acc, Count, Char, _) ->
    NewAcc = Acc ++ [Char | integer_to_list(Count)],
    compress(T, NewAcc, 1, H, 1).