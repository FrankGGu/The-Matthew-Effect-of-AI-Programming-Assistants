-module(solution).
-export([waysToReachStair/1]).

waysToReachStair(K) ->
    % Initial state: current_stair=0, jumps_forward=0, last_move_was_backward=false (meaning we CAN jump backward)
    {Ways, _Memo} = dfs(0, 0, false, K, #{}).
    Ways.

dfs(CurrentStair, JumpsForward, LastMoveWasBackward, K, Memo) ->
    Key = {CurrentStair, JumpsForward, LastMoveWasBackward},
    case maps:find(Key, Memo) of
        {ok, Value} -> {Value, Memo};
        error ->
            % Base cases for pruning search space
            if
                % If we go beyond K+1, we cannot reach K by only jumping backward (max -1 jump).
                CurrentStair > K + 1 ->
                    {0, maps:put(Key, 0, Memo)};
                % Max relevant consecutive forward jumps for K=30. (2^6=64, 2^5=32).
                % If JumpsForward is 6, next jump is 2^6=64. Even from CurrentStair=0, NextStairF=64, which is > K+1 for K=30.
                JumpsForward > 6 ->
                    {0, maps:put(Key, 0, Memo)};
                % Invalid state
                CurrentStair < 0 ->
                    {0, maps:put(Key, 0, Memo)};
                true ->
                    % Calculate ways for current state
                    Ways = if CurrentStair == K -> 1; true -> 0 end,

                    % Option 1: Jump forward
                    NextStairF = CurrentStair + (1 band_shl JumpsForward),
                    {WaysF, Memo1} = dfs(NextStairF, JumpsForward + 1, false, K, Memo),
                    TotalWays = Ways + WaysF,

                    % Option 2: Jump backward
                    % Only if last move was NOT backward AND current_stair > 0
                    if
                        not LastMoveWasBackward andalso CurrentStair > 0 ->
                            {WaysB, Memo2} = dfs(CurrentStair - 1, 0, true, K, Memo1),
                            {TotalWays + WaysB, maps:put(Key, TotalWays + WaysB, Memo2)};
                        true ->
                            {TotalWays, maps:put(Key, TotalWays, Memo1)}
                    end
            end
    end.