-module(string_compression).
-export([compress/1]).

compress(Str) ->
    compress(Str, [], 0, $0).

compress([], Acc, Count, _) ->
    lists:reverse(Acc);
compress([H | T], Acc, Count, Current) when H == Current ->
    compress(T, Acc, Count + 1, Current);
compress([H | T], Acc, Count, Current) ->
    NewAcc = case Count of
        0 -> Acc;
        _ -> [Current, integer_to_list(Count) | Acc]
    end,
    compress(T, NewAcc, 1, H).

compress([], Acc) ->
    lists:reverse(Acc);
compress([H | T], Acc) ->
    compress(T, [H | Acc]).