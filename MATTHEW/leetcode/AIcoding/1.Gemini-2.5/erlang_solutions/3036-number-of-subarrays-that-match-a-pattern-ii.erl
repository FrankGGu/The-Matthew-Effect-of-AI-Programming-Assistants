-module(solution).
-export([number_of_subarrays/2]).

number_of_subarrays(Nums, Pattern) ->
    % 1. Transform Nums into a list of differences
    DiffList = transform_nums_to_diff_list(Nums),

    % Convert DiffList and Pattern to arrays for O(1) element access
    TextArray = array:from_list(DiffList),
    PatternArray = array:from_list(Pattern),

    TextLen = array:size(TextArray),
    PatternLen = array:size(PatternArray),

    % Handle edge cases where a match is impossible
    case PatternLen of
        0 -> 0; % An empty pattern cannot match any subarray (problem constraints imply PatternLen >= 1)
        _ when PatternLen > TextLen -> 0; % Pattern is longer than the text derived from Nums
        _ ->
            % 2. Compute the Longest Proper Prefix Suffix (LPS) array for the pattern
            LPSArray = compute_lps_array(PatternArray, PatternLen),
            % 3. Perform KMP search to count occurrences
            kmp_search(TextArray, PatternArray, LPSArray, TextLen, PatternLen)
    end.

transform_nums_to_diff_list(Nums) ->
    transform_nums_to_diff_list(Nums, []).

transform_nums_to_diff_list([_], Acc) ->
    lists:reverse(Acc);
transform_nums_to_diff_list([H1, H2 | T], Acc) ->
    Val = case H2 of
              _ when H2 > H1 -> 1;
              _ when H2 < H1 -> -1;
              _ -> 0
          end,
    transform_nums_to_diff_list([H2 | T], [Val | Acc]).

compute_lps_array(PatternArray, PatternLen) ->
    % Initialize LPS array with all zeros. LPS[0] is always 0.
    LPS = array:new([{fixed, true}, {size, PatternLen}, {default, 0}]),
    compute_lps_array_loop(PatternArray, LPS, 0, 1, PatternLen).

compute_lps_array_loop(PatternArray, LPS, Len, I, N) when I < N ->
    Pat_I = array:get(I, PatternArray),
    Pat_Len = array:get(Len, PatternArray), % Pattern[Len]

    case Pat_I == Pat_Len of
        true ->
            % Characters match, extend the current prefix/suffix length
            NewLen = Len + 1,
            NewLPS = array:set(I, NewLen, LPS),
            compute_lps_array_loop(PatternArray, NewLPS, NewLen, I + 1, N);
        false ->
            % Mismatch
            case Len of
                0 ->
                    % If Len is 0, no previous prefix exists, so LPS[I] remains 0
                    % (already set by default), and we move to the next character in pattern.
                    compute_lps_array_loop(PatternArray, LPS, 0, I + 1, N);
                _ ->
                    % If Len is not 0, we use the LPS value of the previous prefix
                    % to find a shorter prefix that could match. 'I' is not incremented.
                    NewLen = array:get(Len - 1, LPS),
                    compute_lps_array_loop(PatternArray, LPS, NewLen, I, N)
            end
    end;
compute_lps_array_loop(_, LPS, _, _, _) ->
    LPS.

kmp_search(TextArray, PatternArray, LPSArray, TextLen, PatternLen) ->
    kmp_search_loop(TextArray, PatternArray, LPSArray, TextLen, PatternLen, 0, 0, 0).

kmp_search_loop(TextArray, PatternArray, LPSArray, TextLen, PatternLen, I, J, Count) when I < TextLen ->
    Text_I = array:get(I, TextArray),
    Pat_J = array:get(J, PatternArray),

    case Text_I == Pat_J of
        true ->
            % Characters match, advance both pointers
            NewJ = J + 1,
            case NewJ == PatternLen of
                true ->
                    % A full pattern match is found
                    NewCount = Count + 1,
                    % To find subsequent (potentially overlapping) matches,
                    % we shift the pattern using the LPS array.
                    % The next 'J' is the length of the longest proper prefix of the matched pattern
                    % that is also its suffix.
                    ShiftJ = array:get(NewJ - 1, LPSArray),
                    kmp_search_loop(TextArray, PatternArray, LPSArray, TextLen, PatternLen, I + 1, ShiftJ, NewCount);
                false ->
                    % Continue matching the pattern
                    kmp_search_loop(TextArray, PatternArray, LPSArray, TextLen, PatternLen, I + 1, NewJ, Count)
            end;
        false ->
            % Mismatch
            case J of
                0 ->
                    % If J is 0, no prefix of the pattern has matched, so just advance text pointer
                    kmp_search_loop(TextArray, PatternArray, LPSArray, TextLen, PatternLen, I + 1, 0, Count);
                _ ->
                    % If J is not 0, use the LPS array to shift the pattern.
                    % 'I' is not incremented as we re-evaluate Text[I] with the shifted pattern.
                    NewJ = array:get(J - 1, LPSArray),
                    kmp_search_loop(TextArray, PatternArray, LPSArray, TextLen, PatternLen, I, NewJ, Count)
            end
    end;
kmp_search_loop(_, _, _, _, _, _, _, Count) ->
    % All characters in TextArray have been processed
    Count.