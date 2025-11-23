-module(solution).
-export([decode/1]).

decode(Encoded) ->
    N = length(Encoded) + 1,
    TotalXor = lists:foldl(fun(X, Acc) -> Acc bxor X end, 0, lists:seq(1, N)),
    FirstXor = lists:foldl(fun(X, Acc) -> Acc bxor X end, 0, lists:seq(1, N-1, 2)),
    First = TotalXor bxor FirstXor,
    decode_helper(Encoded, [First]).

decode_helper([], Acc) ->
    lists:reverse(Acc);
decode_helper([H|T], [Prev|_]=Acc) ->
    Next = Prev bxor H,
    decode_helper(T, [Next|Acc]).