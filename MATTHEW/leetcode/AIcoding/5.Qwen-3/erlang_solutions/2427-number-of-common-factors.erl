-module(number_of_common_factors).
-export([common_factors/2]).

common_factors(A, B) ->
    Max = erlang:abs(A),
    Min = erlang:abs(B),
    common_factors(Max, Min, 1, 0).

common_factors(_, _, N, Count) when N > min(Max, Min) ->
    Count;
common_factors(Max, Min, N, Count) ->
    case (Max rem N == 0) and (Min rem N == 0) of
        true -> common_factors(Max, Min, N + 1, Count + 1);
        false -> common_factors(Max, Min, N + 1, Count)
    end.