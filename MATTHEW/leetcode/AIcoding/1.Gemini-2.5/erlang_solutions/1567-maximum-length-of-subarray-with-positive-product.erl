-module(solution).
-export([getMaxLen/1]).

getMaxLen(Nums) ->
    {MaxLen, _, _} = lists:foldl(
        fun(Num, {CurrentMaxLen, CurrentPosLen, CurrentNegLen}) ->
            case Num of
                0 ->
                    % If we encounter a zero, any subarray containing it will have a product of zero.
                    % So, we reset positive and negative lengths.
                    {CurrentMaxLen, 0, 0};
                N when N > 0 ->
                    % If the current number is positive:
                    % A positive sequence extends by 1.
                    NewPosLen = CurrentPosLen + 1,
                    % A negative sequence extends by 1, if it existed. Otherwise, it remains 0.
                    NewNegLen = if CurrentNegLen > 0 -> CurrentNegLen + 1;
                                  true -> 0
                                end,
                    % Update the overall maximum length
                    {erlang:max(CurrentMaxLen, NewPosLen), NewPosLen, NewNegLen};
                N when N < 0 ->
                    % If the current number is negative:
                    % The new positive length comes from extending a previous negative sequence.
                    % If there was no previous negative sequence, a negative number cannot start a positive sequence.
                    PrevPosLen = CurrentPosLen,
                    PrevNegLen = CurrentNegLen,

                    NewPosLen = if PrevNegLen > 0 -> PrevNegLen + 1;
                                  true -> 0
                                end,
                    % The new negative length comes from extending a previous positive sequence,
                    % or if there was no positive sequence, this negative number itself forms a negative sequence of length 1.
                    NewNegLen = PrevPosLen + 1,

                    % Update the overall maximum length
                    {erlang:max(CurrentMaxLen, NewPosLen), NewPosLen, NewNegLen}
            end
        end,
        {0, 0, 0}, % Initial state: {MaxLen, PosLen, NegLen}
        Nums
    ),
    MaxLen.