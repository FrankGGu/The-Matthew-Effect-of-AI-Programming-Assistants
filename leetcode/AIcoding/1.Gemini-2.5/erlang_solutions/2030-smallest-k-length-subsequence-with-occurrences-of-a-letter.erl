-module(solution).
-export([smallest_k_length_subsequence_with_occurrences/4]).

calculate_suffix_letter_counts(S, Letter) ->
    lists:foldr(
        fun(Char, Acc) ->
            [ (hd(Acc) + (if Char == Letter -> 1; true -> 0 end)) | Acc ]
        end,
        [0], % Initial accumulator for the empty suffix S[N..N-1]
        S
    ).

smallest_k_length_subsequence_with_occurrences(S, K, Letter, Repetition) ->
    N = length(S),
    SuffixLetterCounts = calculate_suffix_letter_counts(S, Letter), % SuffixLetterCounts is 1-indexed for element/Nth, but conceptually 0-indexed for S[i:]

    {FinalStack, _} = lists:foldl(
        fun(Idx, {AccStack, AccLetterCount}) ->
            Char = element(Idx + 1, S), % Get character at 0-indexed position 'Idx'
            RemainingCharsInS = N - Idx, % Number of characters from current 'Idx' to N-1 (inclusive)
            % RemainingLettersInSuffix is count of 'Letter' in S[Idx+1 .. N-1]
            % This corresponds to element(Idx + 2, SuffixLetterCounts)
            RemainingLettersInSuffix = element(Idx + 2, SuffixLetterCounts),

            % Phase 1: Pop elements from stack
            {UpdatedStack, UpdatedLetterCount} = pop_loop(
                AccStack, AccLetterCount, Char, RemainingCharsInS, RemainingLettersInSuffix, K, Letter, Repetition
            ),

            % Phase 2: Add Char to stack
            ShouldAddChar =
                if
                    length(UpdatedStack) < K -> % If there's space in the stack
                        if
                            Char == Letter ->
                                true; % Always add 'Letter' if there's space
                            true -> % Char /= Letter
                                % Only add non-'Letter' if we can still meet 'Repetition' later
                                (UpdatedLetterCount + RemainingLettersInSuffix >= Repetition)
                        end;
                    true -> % length(UpdatedStack) == K, no space for new character
                        false
                end,

            if
                ShouldAddChar ->
                    NewAccStack = [Char | UpdatedStack],
                    NewAccLetterCount = UpdatedLetterCount + (if Char == Letter -> 1; true -> 0 end),
                    {NewAccStack, NewAccLetterCount};
                true ->
                    {UpdatedStack, UpdatedLetterCount}
            end
        end,
        {[], 0}, % Initial empty stack and 0 letter count
        lists:seq(0, N - 1) % Iterate through 0-indexed positions of S
    ),

    lists:reverse(FinalStack). % Stack was built in reverse order

pop_loop(Stack, CurrentLetterCountInStack, Char, RemainingCharsInS, RemainingLettersInSuffix, K, Letter, Repetition) ->
    if
        Stack == [] ->
            {Stack, CurrentLetterCountInStack};
        true ->
            TopChar = hd(Stack),
            CanPopTopChar = false,

            % Check if popping TopChar would allow meeting the Repetition constraint
            CanMeetRepetitionAfterPop =
                if
                    TopChar == Letter ->
                        (CurrentLetterCountInStack - 1 + RemainingLettersInSuffix >= Repetition);
                    true -> % TopChar /= Letter
                        (CurrentLetterCountInStack + RemainingLettersInSuffix >= Repetition)
                end,

            if
                Char < TopChar ->
                    % Standard smallest subsequence pop logic: pop if Char is smaller and length/repetition constraints allow
                    if
                        length(Stack) - 1 + RemainingCharsInS >= K and CanMeetRepetitionAfterPop ->
                            CanPopTopChar = true;
                        true ->
                            CanPopTopChar = false
                    end;
                true -> % Char >= TopChar
                    % Special case: If TopChar is not 'Letter', Char is 'Letter', and we still need 'Letter's
                    % We are forced to replace a non-letter with a needed letter, if length allows
                    if
                        TopChar /= Letter and Char == Letter and CurrentLetterCountInStack < Repetition ->
                            if
                                length(Stack) - 1 + RemainingCharsInS >= K ->
                                    CanPopTopChar = true;
                                true ->
                                    CanPopTopChar = false
                            end;
                        true ->
                            CanPopTopChar = false
                    end
            end,

            if
                CanPopTopChar ->
                    NewStack = tl(Stack),
                    NewLetterCount = CurrentLetterCountInStack - (if TopChar == Letter -> 1; true -> 0 end),
                    pop_loop(NewStack, NewLetterCount, Char, RemainingCharsInS, RemainingLettersInSuffix, K, Letter, Repetition);
                true ->
                    {Stack, CurrentLetterCountInStack}
            end
    end.