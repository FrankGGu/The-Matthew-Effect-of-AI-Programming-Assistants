-module(decompress_rl_encoded_list).
-export([decompressRLElist/1]).

decompressRLElist(Nums) ->
  decompressRLElist(Nums, []).

decompressRLElist([], Acc) ->
  lists:reverse(Acc);
decompressRLElist([Freq, Val | Rest], Acc) ->
  NewAcc = lists:append(lists:duplicate(Freq, Val), Acc),
  decompressRLElist(Rest, NewAcc).