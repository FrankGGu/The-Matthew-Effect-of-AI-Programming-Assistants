-module(solution).
-export([max_length_subsequence/1]).

max_length_subsequence(Nums) ->
    case Nums of
        [] -> 0;
        _ ->
            % dp: Map from Value to another Map.
            % The inner map stores lengths for subsequences ending with 'Value',
            % categorized by the difference between 'Value' and its preceding element.
            % DiffIndex mapping:
            %   0 -> -1 (meaning PrevVal = Value + 1)
            %   1 -> 0  (meaning PrevVal = Value)
            %   2 -> 1  (meaning PrevVal = Value - 1)

            % Initial state: dp is an empty map, CurrentMaxLen is 0.
            % CurrentMaxLen will be at least 1 if Nums is not empty.
            {_FinalDp, MaxLen} = lists:foldl(
                fun(Num, {Dp, CurrentMaxLen}) ->
                    % Calculate lengths for subsequences ending with 'Num',
                    % considering the three possible previous values.

                    % Length for diff = -1 (previous element was Num + 1)
                    PrevValForDiffNeg1 = Num + 1,
                    LenForDiffNeg1 = case maps:find(PrevValForDiffNeg1, Dp) of
                                       {ok, PrevValDpEntry} ->
                                           % If there are subsequences ending at PrevValForDiffNeg1,
                                           % take the max length among them and extend it by 1.
                                           lists:max(maps:values(PrevValDpEntry)) + 1;
                                       _ -> 1 % Otherwise, Num starts a new subsequence of length 1.
                                   end,

                    % Length for diff = 0 (previous element was Num)
                    PrevValForDiff0 = Num,
                    LenForDiff0 = case maps:find(PrevValForDiff0, Dp) of
                                       {ok, PrevValDpEntry} ->
                                           lists:max(maps:values(PrevValDpEntry)) + 1;
                                       _ -> 1
                                   end,

                    % Length for diff = 1 (previous element was Num - 1)
                    PrevValForDiffPos1 = Num - 1,
                    LenForDiffPos1 = case maps:find(PrevValForDiffPos1, Dp) of
                                       {ok, PrevValDpEntry} ->
                                           lists:max(maps:values(PrevValDpEntry)) + 1;
                                       _ -> 1
                                   end,

                    % Store the calculated lengths for the current 'Num' in the DP map.
                    % This creates or updates the entry for 'Num'.
                    UpdatedNumEntry = #{0 => LenForDiffNeg1, 1 => LenForDiff0, 2 => LenForDiffPos1},
                    NewDp = maps:put(Num, UpdatedNumEntry, Dp),

                    % Update the overall maximum length found so far.
                    NewMaxLen = max(CurrentMaxLen, max(LenForDiffNeg1, max(LenForDiff0, LenForDiffPos1))),

                    {NewDp, NewMaxLen}
                end,
                {#{}, 0}, % Initial Dp map and MaxLen
                Nums
            ),
            MaxLen
    end.