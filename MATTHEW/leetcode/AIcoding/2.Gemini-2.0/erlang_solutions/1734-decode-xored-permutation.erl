-module(decode_xor_permutation).
-export([decode/1]).

decode(Encoded) ->
  N = length(Encoded) + 1,
  TotalXor = lists:foldl(fun(X, Acc) -> X xor Acc end, 0, lists:seq(1, N)),
  EncodedXor = lists:foldl(fun(X, Acc) -> X xor Acc end, 0, lists:sublist(Encoded, 2, N - 1)),
  First = TotalXor xor EncodedXor,
  Result = [First | lists:foldl(fun(X, Acc) -> [X xor hd(Acc) | Acc] end, [], Encoded)],
  lists:reverse(Result).