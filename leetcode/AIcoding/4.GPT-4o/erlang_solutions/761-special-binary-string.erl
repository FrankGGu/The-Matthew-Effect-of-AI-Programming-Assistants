-module(solution).
-export([make_special_binary_string/1]).

make_special_binary_string(S) ->
    {Result, _} = make_special_binary_string(S, []),
    lists:reverse(Result).

make_special_binary_string([], Acc) ->
    {Acc, []};
make_special_binary_string([?X | Rest], Acc) when ?X =:= $1 ->
    {NewAcc, Remaining} = make_special_binary_string(Rest, [1 | Acc]),
    {NewAcc, Remaining};
make_special_binary_string([?X | Rest], Acc) when ?X =:= $0 ->
    {Acc, [0 | Rest]};
make_special_binary_string([?X | Rest], Acc) when ?X =:= $1 ->
    {Inner, NewRest} = make_special_binary_string(Rest, Acc),
    {NewAcc, Remaining} = make_special_binary_string(NewRest, [1 | Inner]),
    {NewAcc, Remaining}.