-module(solution).
-export([earliest_and_latest/3]).

-spec earliest_and_latest(N :: integer(), FirstPlayer :: integer(), SecondPlayer :: integer()) -> [integer()].
earliest_and_latest(N, FirstPlayer, SecondPlayer) ->
    {Min, Max} = solve(N, FirstPlayer, SecondPlayer),
    [Min, Max].

solve(N, F, S) ->
    case F + S == N + 1 of
        true -> {1, 1};
        false ->
            Min = min_round(N, F, S),
            Max = max_round(N, F, S),
            {Min, Max}
    end.

min_round(N, F, S) ->
    case (F =< (N + 1) div 2) and (S =< (N + 1) div 2) of
        true -> 1;
        false ->
            NewF = if F > (N + 1) div 2 -> N + 1 - F; true -> F end,
            NewS = if S > (N + 1) div 2 -> N + 1 - S; true -> S end,
            1 + min_round((N + 1) div 2, NewF, NewS)
    end.

max_round(N, F, S) ->
    case (F + S == N + 1) of
        true -> 1;
        false ->
            NewF = if F > (N + 1 - S) -> F - (N + 1 - S); true -> F end,
            NewS = if S > (N + 1 - F) -> S - (N + 1 - F); true -> S end,
            1 + max_round(N div 2, NewF, NewS)
    end.