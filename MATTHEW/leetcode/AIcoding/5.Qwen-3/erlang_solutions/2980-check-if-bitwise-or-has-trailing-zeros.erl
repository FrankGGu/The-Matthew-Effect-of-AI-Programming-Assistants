-module(solution).
-export([has_trailing_zeros/1]).

has_trailing_zeros(Nums) ->
    N = length(Nums),
    check_trailing_zeros(Nums, N).

check_trailing_zeros([], _) ->
    true;
check_trailing_zeros([H | T], N) ->
    case (H band 1) of
        0 ->
            check_trailing_zeros(T, N);
        _ ->
            false
    end.