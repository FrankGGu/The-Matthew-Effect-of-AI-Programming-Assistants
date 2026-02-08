-module(find_missing_observations).
-export([missing_observation/2]).

missing_observation(Expectations, S) ->
    N = length(Expectations),
    Total = lists:sum(Expectations),
    Required = S * N,
    Diff = Required - Total,
    if
        Diff < N -> [];
        true ->
            Base = Diff div N,
            Remainder = Diff rem N,
            [Base + 1 || _ <- lists:seq(1, Remainder)] ++ [Base || _ <- lists:seq(1, N - Remainder)]
    end.