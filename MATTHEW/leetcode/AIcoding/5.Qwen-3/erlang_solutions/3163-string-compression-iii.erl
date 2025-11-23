-module(string_compression_iii).
-export([compress/1]).

compress(Str) ->
    compress(Str, 0, []).

compress([], _, Acc) ->
    lists:reverse(Acc);
compress([C | Rest], Count, Acc) ->
    case Rest of
        [C | _] ->
            compress(Rest, Count + 1, Acc);
        _ ->
            NewAcc = [C | integer_to_list(Count + 1) | Acc],
            compress(Rest, 0, NewAcc)
    end.