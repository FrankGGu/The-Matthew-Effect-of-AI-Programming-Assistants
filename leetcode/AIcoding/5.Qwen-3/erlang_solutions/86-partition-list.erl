-module(partition_list).
-export([partition/2]).

partition(_, []) -> [];
partition(X, [H|T]) ->
    if
        H < X -> [H | partition(X, T)];
        true -> partition(X, T) ++ [H]
    end.