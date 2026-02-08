-module(solution).
-export([largestVariance/1]).

largestVariance(S) ->
    Chars = string:to_list(S),
    AllUniqueChars = lists:usort(Chars), % Get unique characters to iterate over

    lists:foldl(fun(Char1, AccMaxVariance) ->
        lists:foldl(fun(Char2, AccMaxVarianceInner) ->
            if Char1 == Char2 ->
                AccMaxVarianceInner;
            true ->
                % Kadane's algorithm variant for a fixed pair (Char1, Char2)
                % We want to maximize (count_Char1 - count_Char2) in a substring
                % where both Char1 and Char2 are present.

                % State for foldl: {MaxVarianceForPair, CountChar1, CountChar2, HasChar2InCurrentSegment}
                InitialState = {0, 0, 0, false},

                {FinalMaxVarianceForPair, _, _, _} = lists:foldl(fun(Char, {MaxV, C1, C2, HasChar2}) ->
                    NewC1 = C1,
                    NewC2 = C2,
                    NewHasChar2 = HasChar2,

                    case Char of
                        Char1 ->
                            NewC1_after_char = NewC1 + 1,
                            NewC2_after_char = NewC2;
                        Char2 ->
                            NewC1_after_char = NewC1,
                            NewC2_after_char = NewC2 + 1,
                            NewHasChar2_after_char = true; % Char2 has been seen in this segment
                        _ ->
                            NewC1_after_char = NewC1,
                            NewC2_after_char = NewC2,
                            NewHasChar2_after_char = NewHasChar2
                    end,

                    UpdatedMaxV = if NewHasChar2_after_char ->
                                        max(MaxV, NewC1_after_char - NewC2_after_char);
                                   true ->
                                        % If Char2 has not been seen yet in this segment,
                                        % we can't directly use C1 - C2.
                                        % The trick is to subtract 1 from C1 to simulate
                                        % the presence of one Char2. This is valid only if C1 > 0.
                                        if NewC1_after_char > 0 ->
                                            max(MaxV, NewC1_after_char - 1);
                                        true ->
                                            MaxV
                                        end
                                   end,

                    {NextC1, NextC2, NextHasChar2} = if NewC1_after_char < NewC2_after_char ->
                                                          % If count of Char1 drops below count of Char2,
                                                          % reset the segment. This is Kadane's core.
                                                          {0, 0, false};
                                                     true ->
                                                          {NewC1_after_char, NewC2_after_char, NewHasChar2_after_char}
                                                     end,

                    {UpdatedMaxV, NextC1, NextC2, NextHasChar2}
                end, InitialState, Chars),

                max(AccMaxVarianceInner, FinalMaxVarianceForPair)
            end
        end, AccMaxVariance, AllUniqueChars)
    end, 0, AllUniqueChars).