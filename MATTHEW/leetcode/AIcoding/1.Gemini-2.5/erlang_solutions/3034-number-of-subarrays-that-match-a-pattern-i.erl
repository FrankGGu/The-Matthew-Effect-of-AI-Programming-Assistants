-module(solution).
-export([count_matching_subarrays/2]).

-include_lib("array/include/array.hrl").

diff_val(A, B) when B > A -> 1;
diff_val(A, B) when B < A -> -1;
diff_val(A, B) when B == A -> 0.

make_diff_nums([_]) -> [];
make_diff_nums([H1, H2 | T]) ->
    [diff_val(H1, H2) | make_diff_nums([H2 | T])].

compute_lps(PatternArray) ->
    M = array:size(PatternArray),
    LPS = array:new([{size, M}, {default, 0}]),

    % Len: length of the previous longest prefix suffix
    % I: current index for PatternArray (being processed)
    compute_lps_loop(PatternArray, M, LPS, 0, 1).

compute_lps_loop(_, M, LPS, _, I) when I >= M ->
    LPS;
compute_lps_loop(PatternArray, M, LPS, Len, I) ->
    Pat_I = array:get(I, PatternArray),
    Pat_Len = array:get(Len, PatternArray),

    if Pat_I == Pat_Len ->
        NewLen = Len + 1,
        NewLPS = array:set(I, NewLen, LPS),
        compute_lps_loop(PatternArray, M, NewLPS, NewLen, I + 1);
    true ->
        if Len /= 0 ->
            % This is tricky. We need to go back to the previous LPS value
            % for the (Len-1)-th character.
            NewLen = array:get(Len - 1, LPS),
            compute_lps_loop(PatternArray, M, LPS, NewLen, I);
        true ->
            % If Len is 0, no prefix matched, so LPS[I] is 0
            NewLPS = array:set(I, 0, LPS),
            compute_lps_loop(PatternArray, M, NewLPS, 0, I + 1)
        end
    end.

kmp_search(DiffNumsArray, PatternArray, LPS) ->
    N = array:size(DiffNumsArray),
    M = array:size(PatternArray),

    % TxtIdx: current index in DiffNumsArray (text)
    % PatIdx: current index in PatternArray
    % Count: number of matches found
    kmp_search_loop(DiffNumsArray, PatternArray, LPS, N, M, 0, 0, 0).

kmp_search_loop(_, _, _, N, M, TxtIdx, _, Count) when TxtIdx >= N ->
    Count;
kmp_search_loop(DiffNumsArray, PatternArray, LPS, N, M, TxtIdx, PatIdx, Count) ->
    Txt_TxtIdx = array:get(TxtIdx, DiffNumsArray),
    Pat_PatIdx = array:get(PatIdx, PatternArray),

    if Txt_TxtIdx == Pat_PatIdx ->
        NewTxtIdx = TxtIdx + 1,
        NewPatIdx = PatIdx + 1,
        if NewPatIdx == M -> % Pattern found
            NewCount = Count + 1,
            % Shift pattern based on LPS array (M-1 is the last index)
            NewPatIdxAfterMatch = array:get(M - 1, LPS),
            kmp_search_loop(DiffNumsArray, PatternArray, LPS, N, M, NewTxtIdx, NewPatIdxAfterMatch, NewCount);
        true ->
            kmp_search_loop(DiffNumsArray, PatternArray, LPS, N, M, NewTxtIdx, NewPatIdx, Count)
        end;
    true ->
        if PatIdx /= 0 ->
            % Mismatch, shift pattern using LPS
            NewPatIdx = array:get(PatIdx - 1, LPS),
            kmp_search_loop(DiffNumsArray, PatternArray, LPS, N, M, TxtIdx, NewPatIdx, Count);
        true ->
            % If PatIdx is 0, no prefix matched, just move to the next character in text
            NewTxtIdx = TxtIdx + 1,
            kmp_search_loop(DiffNumsArray, PatternArray, LPS, N, M, NewTxtIdx, 0, Count)
        end
    end.

count_matching_subarrays(Nums, Pattern) ->
    DiffNumsList = make_diff_nums(Nums),

    M = length(Pattern),
    N_prime = length(DiffNumsList), % Length of DiffNumsList (which is N-1)

    % Handle edge case where Pattern is longer than DiffNumsList
    % If M > N_prime, no match is possible.
    if M > N_prime ->
        0;
    true ->
        % Convert lists to arrays for O(1) indexed access
        DiffNumsArray = array:from_list(DiffNumsList),
        PatternArray = array:from_list(Pattern),

        LPS = compute_lps(PatternArray),
        kmp_search(DiffNumsArray, PatternArray, LPS)
    end.