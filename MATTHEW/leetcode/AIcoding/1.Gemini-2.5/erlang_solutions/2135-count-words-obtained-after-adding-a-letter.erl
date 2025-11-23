-module(solution).
-export([wordCount/2]).

wordCount(StartWords, TargetWords) ->
    % Step 1: Canonicalize all start words by sorting their characters and store them
    % in a map for efficient O(1) average time lookup.
    StartWordSet = build_start_word_set(StartWords),

    % Step 2: Iterate through each target word and check if it can be formed.
    % Accumulate the count of valid target words.
    count_target_words(TargetWords, StartWordSet).

build_start_word_set(StartWords) ->
    lists:foldl(fun(Word, Acc) ->
                        Chars = binary_to_list(Word),
                        SortedChars = lists:sort(Chars),
                        SortedBinary = list_to_binary(SortedChars),
                        maps:put(SortedBinary, true, Acc)
                end, maps:new(), StartWords).

count_target_words(TargetWords, StartWordSet) ->
    lists:foldl(fun(TargetWord, Acc) ->
                        case can_form_target_word(TargetWord, StartWordSet) of
                            true -> Acc + 1;
                            false -> Acc
                        end
                end, 0, TargetWords).

can_form_target_word(TargetWord, StartWordSet) ->
    TargetChars = binary_to_list(TargetWord),
    % Iterate through all possible lowercase English letters ('a' to 'z').
    % For each letter, try removing it from the target word and check if the result
    % (after sorting) exists in the StartWordSet.
    try_removing_char(TargetChars, $a, StartWordSet).

try_removing_char(_TargetChars, Char, _StartWordSet) when Char > $z ->
    % Base case: All characters 'a' through 'z' have been tried without finding a match.
    false;
try_removing_char(TargetChars, Char, StartWordSet) ->
    % Attempt to remove the current 'Char' from TargetChars.
    % lists:delete removes the first occurrence. If Char is not present, it returns TargetChars unchanged.
    RemainingChars = lists:delete(Char, TargetChars),

    % Check if a character was successfully removed, meaning its length is exactly one less.
    % This also ensures the length constraint (target_length = start_length + 1).
    if
        length(RemainingChars) == length(TargetChars) - 1 ->
            % If a character was removed, sort the remaining characters to get the canonical form.
            SortedRemainingChars = lists:sort(RemainingChars),
            SortedRemainingBinary = list_to_binary(SortedRemainingChars),

            % Check if this canonical form exists in our set of start words.
            case maps:is_key(SortedRemainingBinary, StartWordSet) of
                true -> 
                    % Found a match: this TargetWord can be formed. Return true immediately.
                    true;
                false -> 
                    % No match with this particular character removed, try the next character.
                    try_removing_char(TargetChars, Char + 1, StartWordSet)
            end;
        true -> % The 'Char' was not present in TargetChars (length did not decrease by 1).
                % Continue to the next character without checking StartWordSet.
            try_removing_char(TargetChars, Char + 1, StartWordSet)
    end.