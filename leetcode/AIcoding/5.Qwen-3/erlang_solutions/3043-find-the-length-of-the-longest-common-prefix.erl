-module(solution).
-export([length_of_longest_common_prefix/1]).

length_of_longest_common_prefix(Nums) ->
    lists:foldl(fun(X, Acc) -> min(Acc, length(common_prefix(Nums, X))) end, infinity, Nums).

common_prefix([], _) -> 0;
common_prefix([H | T], Index) ->
    case lists:all(fun(N) -> element(Index, N) == element(Index, H) end, T) of
        true -> 1 + common_prefix(T, Index + 1);
        false -> 0
    end.