-module(solution).
-export([compressed_string/1]).

compressed_string(S) ->
    compressed_string(S, [], 0).

compressed_string([], Acc, _) ->
    lists:reverse(Acc);
compressed_string([H|T], [], 0) ->
    compressed_string(T, [H], 1);
compressed_string([H|T], [H|AccTail], Count) ->
    compressed_string(T, [H|AccTail], Count + 1);
compressed_string([H|T], Acc, Count) when Count > 1 ->
    NewAcc = lists:reverse(integer_to_list(Count)) ++ [lists:nth(1, Acc)] ++ lists:nthtail(1, Acc),
    compressed_string([H|T], NewAcc, 0);
compressed_string([H|T], Acc, 1) ->
    compressed_string([H|T], Acc, 0);
compressed_string([H|T], Acc, 0) ->
    compressed_string(T, [H|Acc], 1).