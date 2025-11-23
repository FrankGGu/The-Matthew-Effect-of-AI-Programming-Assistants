-module(solution).
-export([minimum_length_encoding/1]).

minimum_length_encoding(Words) ->
    UniqueWords = lists:usort(Words),
    EncodedWords = lists:map(fun(W) -> W ++ "#" end, UniqueWords),
    Lengths = lists:map(fun(W) -> length(W) end, EncodedWords),
    lists:foldl(fun(X, Acc) -> Acc + X end, 0, Lengths).