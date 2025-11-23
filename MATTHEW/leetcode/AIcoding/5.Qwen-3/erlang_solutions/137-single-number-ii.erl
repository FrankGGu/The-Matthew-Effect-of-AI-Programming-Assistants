-module(singleton).
-export([single_number/1]).

single_number([]) -> 0;
single_number([H|T]) ->
    lists:foldl(fun(X, Acc) -> Acc bxor X end, H, T).