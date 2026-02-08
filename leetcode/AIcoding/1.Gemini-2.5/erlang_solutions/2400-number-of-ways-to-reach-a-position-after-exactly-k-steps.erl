-module(solution).
-export([number_of_ways_to_reach_a_position_after_exactly_k_steps/3]).

number_of_ways_to_reach_a_position_after_exactly_k_steps(StartPos, EndPos, K) ->
    Diff = EndPos - StartPos + K,

    % If Diff is odd, it's impossible to reach the target position.
    % This is because (x + y = K) and (StartPos + x - y = EndPos) implies
    % 2x = EndPos - StartPos + K. For x to be an integer, (EndPos - StartPos + K) must be even.
    if
        Diff rem 2 /= 0 ->
            0;
        true ->
            X = Diff div 2,
            % X represents the number of +1 steps.
            % Y = K - X represents the number of -1 steps.
            % Both X and Y must be non-negative and not exceed K.
            % If X < 0 or X > K, it's impossible.
            % (X < 0 implies Diff < 0, meaning EndPos - StartPos + K < 0, or EndPos - StartPos < -K)
            % (X > K implies Diff > 2K, meaning EndPos - StartPos + K > 2K, or EndPos - StartPos > K)
            if
                X < 0 orelse X > K ->
                    0;
                true ->
                    % The number of ways is C(K, X), choosing X steps out of K to be +1.
                    nCr(K, X)
            end
    end.

nCr(N, R) when R < 0; R > N -> 0;
nCr(N, R) when R == 0; R == N -> 1;
nCr(N, R) ->
    % Optimize by using C(N, R) = C(N, N - R)
    ActualR = min(R, N - R),
    nCr_iter(N, ActualR, 1, 1).

nCr_iter(N, R, CurrentI, Acc) when CurrentI > R -> Acc;
nCr_iter(N, R, CurrentI, Acc) ->
    NewAcc = Acc * (N - CurrentI + 1) div CurrentI,
    nCr_iter(N, R, CurrentI + 1, NewAcc).