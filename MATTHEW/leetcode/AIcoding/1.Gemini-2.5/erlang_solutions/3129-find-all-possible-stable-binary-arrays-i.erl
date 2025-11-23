-module(solution).
-export([solve/3]).

solve(Zero, One, Limit) ->
    Mod = 1_000_000_007,
    % Memoization map: Key = {I, J, LastChar}, Value = Count
    Memo = maps:new(),

    % Calculate ways ending with 0
    {Count0, Memo1} = get_dp(Zero, One, 0, Limit, Mod, Memo),

    % Calculate ways ending with 1
    {Count1, _FinalMemo} = get_dp(Zero, One, 1, Limit, Mod, Memo1),

    (Count0 + Count1) rem Mod.

get_dp(I, J, LastChar, Limit, Mod, Memo) ->
    Key = {I, J, LastChar},
    case maps:find(Key, Memo) of
        {ok, Val} ->
            {Val, Memo};
        error ->
            % Calculate value if not in memo
            {Val, NewMemo} = calculate_dp(I, J, LastChar, Limit, Mod, Memo),
            {Val, maps:put(Key, Val, NewMemo)}
    end.

calculate_dp(I, J, LastChar, Limit, Mod, Memo) ->
    if I < 0 orelse J < 0 ->
        {0, Memo}; % Invalid state: negative counts of zeros or ones
    true ->
        if LastChar == 0 -> % We are forming an array ending with a block of zeros
            if I == 0 -> % Cannot end with 0 if no zeros are left
                {0, Memo};
            true ->
                % If J is 0, it means the array consists only of zeros.
                % Valid only if the total number of zeros (I) does not exceed Limit.
                if J == 0 ->
                    if I > 0 andalso I =< Limit ->
                        {1, Memo};
                    true ->
                        {0, Memo}
                    end;
                true -> % J > 0, so we are adding zeros after an array ending in ones
                    CurrentMemo = Memo,
                    % Sum ways by adding k zeros (1 <= k <= Limit)
                    % The previous state must have ended with 1.
                    {FinalSum, FinalMemo} = lists:foldl(
                        fun(K, {AccSum, AccMemo}) ->
                            PrevI = I - K,
                            {PrevCount, UpdatedMemo} = get_dp(PrevI, J, 1, Limit, Mod, AccMemo),
                            {(AccSum + PrevCount) rem Mod, UpdatedMemo}
                        end,
                        {0, CurrentMemo}, % Initial sum is 0
                        lists:seq(1, min(I, Limit))
                    ),
                    {FinalSum, FinalMemo}
                end
            end;
        true -> % LastChar == 1, We are forming an array ending with a block of ones
            if J == 0 -> % Cannot end with 1 if no ones are left
                {0, Memo};
            true ->
                % If I is 0, it means the array consists only of ones.
                % Valid only if the total number of ones (J) does not exceed Limit.
                if I == 0 ->
                    if J > 0 andalso J =< Limit ->
                        {1, Memo};
                    true ->
                        {0, Memo}
                    end;
                true -> % I > 0, so we are adding ones after an array ending in zeros
                    CurrentMemo = Memo,
                    % Sum ways by adding k ones (1 <= k <= Limit)
                    % The previous state must have ended with 0.
                    {FinalSum, FinalMemo} = lists:foldl(
                        fun(K, {AccSum, AccMemo}) ->
                            PrevJ = J - K,
                            {PrevCount, UpdatedMemo} = get_dp(I, PrevJ, 0, Limit, Mod, AccMemo),
                            {(AccSum + PrevCount) rem Mod, UpdatedMemo}
                        end,
                        {0, CurrentMemo}, % Initial sum is 0
                        lists:seq(1, min(J, Limit))
                    ),
                    {FinalSum, FinalMemo}
                end
            end
        end
    end.