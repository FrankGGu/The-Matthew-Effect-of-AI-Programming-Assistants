-module(solution).
-export([decompressRLElist/1]).

decompressRLElist(Nums) ->
    decompress_acc(Nums, []).

decompress_acc([], Acc) ->
    lists:reverse(Acc);
decompress_acc([Freq, Val | Rest], Acc) ->
    NewAcc = generate_copies_and_prepend(Freq, Val, Acc),
    decompress_acc(Rest, NewAcc).

generate_copies_and_prepend(0, _Val, Acc) ->
    Acc;
generate_copies_and_prepend(N, Val, Acc) when N > 0 ->
    generate_copies_and_prepend(N - 1, Val, [Val | Acc]).