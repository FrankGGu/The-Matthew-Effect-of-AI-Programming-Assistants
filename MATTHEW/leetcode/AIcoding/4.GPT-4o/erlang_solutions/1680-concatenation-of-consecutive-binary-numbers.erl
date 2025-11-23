-module(solution).
-export([concatenated_binary/1]).

concatenated_binary(N) ->
    M = 1000000007,
    BinStr = lists:foldl(fun(X, Acc) -> Acc ++ integer_to_list(X, 2) end, [], lists:seq(1, N)),
    BinInt = lists:foldl(fun(X, Acc) -> (Acc * 2 + (X - $0)) rem M end, 0, BinStr),
    BinInt.