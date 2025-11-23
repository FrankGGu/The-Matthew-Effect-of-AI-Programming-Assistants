-module(solution).
-export([min_valid_strings/2]).

min_valid_strings(Target, Words) ->
    TargetLen = length(Target),

    % Infinity is a value larger than any possible valid count.
    % The maximum number of words needed cannot exceed TargetLen (if each word is 1 char).
    Infinity = TargetLen + 1, 

    % Dp is a list where Dp[i] (0-indexed) stores the minimum number of words
    % required to form the prefix Target[0...i-1].
    % Initialize Dp with Infinity for all entries.
    % Dp will have TargetLen + 1 elements, from index 0 to TargetLen.
    InitialDp = lists:duplicate(TargetLen + 1, Infinity),

    % Base case: 0 words are needed to form an empty prefix (Target[0...-1]).
    % This corresponds to Dp[0].
    Dp0 = lists:replace_at(0, 0, InitialDp),

    % Fold over the indices I from 1 to TargetLen.
    % I represents the current prefix length we are trying to form.
    FinalDp = lists:foldl(
        fun(I, CurrentDp) ->
            % CurrentDp is the dp_table after processing up to index I-1.
            % We are now calculating the minimum for Dp[I].

            % Initialize MinWordsForI with the current value in Dp[I] (which is Infinity initially).
            % lists:nth is 1-indexed, so I + 1 gives the element at 0-indexed position I.
            MinWordsForI = lists:nth(I + 1, CurrentDp),

            % Iterate through all available words to find the minimum for Dp[I].
            NewMinForI = lists:foldl(
                fun(Word, AccMin) ->
                    WordLen = length(Word),

                    % Check if the current prefix Target[0...I-1] can end with 'Word'.
                    if
                        I >= WordLen ->
                            % If I is greater than or equal to WordLen, then 'Word' could potentially
                            % be the last word forming Target[0...I-1].
                            % The substring to check is Target[I - WordLen ... I-1].
                            PrefixStart = I - WordLen, % This is the 0-indexed start of the potential substring.

                            % lists:sublist(List, StartIndex, Length) uses a 1-indexed StartIndex.
                            SubTarget = lists:sublist(Target, PrefixStart + 1, WordLen),

                            if
                                SubTarget == Word ->
                                    % If the substring matches 'Word', then we can potentially form
                                    % Target[0...I-1] by taking the minimum words for Target[0...PrefixStart-1]
                                    % (which is Dp[PrefixStart]) and adding 1 for the current 'Word'.
                                    PrevDpValue = lists:nth(PrefixStart + 1, CurrentDp),
                                    min(AccMin, PrevDpValue + 1);
                                true ->
                                    AccMin % No match, keep current minimum.
                            end;
                        true ->
                            AccMin % Word is too long for the current prefix, keep current minimum.
                    end
                end,
                MinWordsForI, % Start with the current (infinity) value for Dp[I].
                Words
            ),

            % Update Dp[I] with the newly calculated minimum.
            % lists:replace_at takes a 0-indexed position.
            lists:replace_at(I, NewMinForI, CurrentDp)
        end,
        Dp0,
        lists:seq(1, TargetLen) % Iterate I from 1 to TargetLen.
    ),

    % The final result is Dp[TargetLen], which is the minimum words for Target[0...TargetLen-1].
    Result = lists:nth(TargetLen + 1, FinalDp),

    % If the result is still Infinity, it means Target cannot be formed.
    if
        Result >= Infinity -> -1;
        true -> Result
    end.