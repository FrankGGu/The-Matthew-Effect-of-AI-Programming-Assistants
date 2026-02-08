-module(solution).
-export([pass_the_pillow/2]).

pass_the_pillow(N, Time) ->
    CycleLength = 2 * (N - 1),
    EffectiveTime = Time rem CycleLength,
    if
        EffectiveTime < (N - 1) ->
            1 + EffectiveTime;
        true ->
            N - (EffectiveTime - (N - 1))
    end.