-module(solution).
-export([separate_squares/1]).

-spec separate_squares(Nums :: [integer()]) -> {[integer()], [integer()]}.
separate_squares(Nums) ->
    separate_squares_acc(Nums, [], []).

separate_squares_acc([], Squares, NonSquares) ->
    {lists:reverse(Squares), lists:reverse(NonSquares)};
separate_squares_acc([H | T], Squares, NonSquares) ->
    if
        is_perfect_square(H) ->
            separate_squares_acc(T, [H | Squares], NonSquares);
        true ->
            separate_squares_acc(T, Squares, [H | NonSquares])
    end.

is_perfect_square(N) when N < 0 -> false;
is_perfect_square(0) -> true;
is_perfect_square(N) ->
    S = round(math:sqrt(N)),
    S * S == N.