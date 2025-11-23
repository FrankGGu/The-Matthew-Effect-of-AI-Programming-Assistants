-module(solution).
-export([hasTrailingZeros/1]).

hasTrailingZeros(Nums) ->
    has_trailing_zeros(Nums, 0).

has_trailing_zeros([], Count) ->
    Count >= 2;
has_trailing_zeros([H|T], Count) ->
    case H rem 2 of
        0 ->
            has_trailing_zeros(T, Count + 1);
        _ ->
            has_trailing_zeros(T, Count)
    end.