-module(solution).
-export([no_zero_in_range/1]).

no_zero_in_range(N) ->
    no_zero_in_range(N, 1).

no_zero_in_range(N, A) ->
    B = N - A,
    case has_no_zero(A) andalso has_no_zero(B) of
        true -> {A, B};
        false -> no_zero_in_range(N, A + 1)
    end.

has_no_zero(0) -> false;
has_no_zero(N) ->
    has_no_zero(N, 10).

has_no_zero(0, _) -> true;
has_no_zero(N, Base) ->
    Digit = N rem Base,
    if
        Digit == 0 -> false;
        true -> has_no_zero(N div Base, Base)
    end.