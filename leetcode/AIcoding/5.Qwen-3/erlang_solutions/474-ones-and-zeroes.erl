-module(solution).
-export([find_max_formed_string/1]).

find_max_formed_string(Strs) ->
    find_max_formed_string(Strs, 0, 0, []).

find_max_formed_string([], _, _, Acc) ->
    lists:reverse(Acc);
find_max_formed_string([Str | Rest], Zeros, Ones, Acc) ->
    {ZeroCount, OneCount} = count_ones_zeros(Str),
    if
        ZeroCount =< Zeros, OneCount =< Ones ->
            NewZeros = Zeros - ZeroCount,
            NewOnes = Ones - OneCount,
            find_max_formed_string(Rest, NewZeros, NewOnes, [Str | Acc]);
        true ->
            find_max_formed_string(Rest, Zeros, Ones, Acc)
    end.

count_ones_zeros(Str) ->
    count_ones_zeros(Str, 0, 0).

count_ones_zeros([], Ones, Zeros) ->
    {Zeros, Ones};
count_ones_zeros([C | Rest], Ones, Zeros) ->
    case C of
        $0 -> count_ones_zeros(Rest, Ones, Zeros + 1);
        _ -> count_ones_zeros(Rest, Ones + 1, Zeros)
    end.