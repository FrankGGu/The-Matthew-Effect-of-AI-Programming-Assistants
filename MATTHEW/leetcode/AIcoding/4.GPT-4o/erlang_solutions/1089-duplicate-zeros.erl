-module(solution).
-export([duplicate_zeros/1]).

duplicate_zeros(L) ->
    duplicate_zeros(L, length(L), 0).

duplicate_zeros(_, 0, _) -> [];
duplicate_zeros(L, N, Index) when N > 0 ->
    case lists:nth(Index + 1, L) of
        0 -> 
            [0 | duplicate_zeros(L, N - 1, Index + 1)];
        _ -> 
            [lists:nth(Index + 1, L) | duplicate_zeros(L, N - 1, Index + 1)]
    end.