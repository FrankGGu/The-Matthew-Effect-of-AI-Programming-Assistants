-module(solution).
-export([findTheChild/2]).

findTheChild(N, K) ->
    if
        N == 1 ->
            0;
        true ->
            CycleLength = 2 * (N - 1),
            EffectiveK = K rem CycleLength,
            if
                EffectiveK < N ->
                    EffectiveK;
                true -> % EffectiveK >= N, meaning the ball is moving back from N-1
                    % The ball reached N-1 after N-1 passes.
                    % Remaining passes after reaching N-1: EffectiveK - (N-1)
                    % The position is (N-1) minus these remaining passes.
                    (N - 1) - (EffectiveK - (N - 1))
            end
    end.