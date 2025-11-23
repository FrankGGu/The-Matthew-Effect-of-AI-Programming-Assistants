-module(valid_perfect_square).
-export([is_perfect_square/1]).

is_perfect_square(N) when N < 1 -> false;
is_perfect_square(N) ->
    is_perfect_square(N, 1, N).

is_perfect_square(N, Low, High) ->
    Mid = (Low + High) div 2,
    case Mid * Mid of
        M when M == N -> true;
        M when M < N -> is_perfect_square(N, Mid + 1, High);
        _ -> is_perfect_square(N, Low, Mid - 1)
    end.