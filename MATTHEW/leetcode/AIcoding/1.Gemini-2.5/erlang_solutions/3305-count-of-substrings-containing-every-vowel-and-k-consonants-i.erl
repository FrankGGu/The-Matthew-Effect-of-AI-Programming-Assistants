-module(solution).
-export([countSubstrings/2]).

is_vowel(C) when C == $a; C == $e; C == $i; C == $o; C == $u -> true;
is_vowel(_) -> false.

vowel_to_idx($a) -> 0;
vowel_to_idx($e) -> 1;
vowel_to_idx($i) -> 2;
vowel_to_idx($o) -> 3;
vowel_to_idx($u) -> 4.

-spec countSubstrings(S :: unicode:unicode_binary(), K :: integer()) -> integer().
countSubstrings(S, K) ->
    Chars = string:to_list(S),
    Result_K = count_at_most(Chars, K),
    Result_K_minus_1 = if K > 0 -> count_at_most(Chars, K - 1);
                       true -> 0
                       end,
    Result_K - Result_K_minus_1.

count_at_most(S_list, K_max) ->
    S_array = array:from_list(S_list),
    N = array:size(S_array),
    % State: S_array, N, K_max, Left (consonant window start), Right,
    % VowelLastSeen (array of 5, init with -1), ConsonantCount, TotalCount
    count_at_most_loop(S_array, N, K_max, 0, 0, array:new(5, [{default, -1}]), 0, 0).

count_at_most_loop(S_array, N, K_max, Left, Right, VowelLastSeen, ConsonantCount, TotalCount) when Right < N ->
    CharR = array:get(Right, S_array),

    % Update counts/last seen for CharR
    {NewVowelLastSeen, NewConsonantCount} =
        if is_vowel(CharR) ->
            Idx = vowel_to_idx(CharR),
            {array:set(Idx, Right, VowelLastSeen), ConsonantCount};
        true -> % CharR is a consonant
            {VowelLastSeen, ConsonantCount + 1}
        end,

    % Shrink Left pointer to satisfy ConsonantCount <= K_max
    {FinalLeft, FinalConsonantCount} =
        shrink_consonant_window(S_array, K_max, Left, NewConsonantCount),

    % Check for all vowels present within the window [FinalLeft, Right]
    % and find the minimum last seen index among them.
    {AllVowelsFound, MinLastVowelIdx} = find_min_last_vowel_idx(NewVowelLastSeen, FinalLeft),

    NewTotalCount = TotalCount,
    ResultTotalCount =
        if AllVowelsFound ->
            % The leftmost start for a window ending at Right satisfying all vowels is MinLastVowelIdx.
            % The leftmost start for a window ending at Right satisfying consonant_count <= K_max is FinalLeft.
            % To satisfy both, the actual leftmost start must be the maximum of these two.
            LeftmostValidStart = max(FinalLeft, MinLastVowelIdx),
            if LeftmostValidStart <= Right -> % Ensure the window is valid (start <= end)
                NewTotalCount + 1; % Count this specific valid window [LeftmostValidStart, Right]
            true ->
                NewTotalCount
            end;
        true ->
            NewTotalCount
        end,

    count_at_most_loop(S_array, N, K_max, FinalLeft, Right + 1, NewVowelLastSeen, FinalConsonantCount, ResultTotalCount);
count_at_most_loop(_, _, _, _, _, _, _, TotalCount) ->
    TotalCount.

shrink_consonant_window(S_array, K_max, Left, ConsonantCount) ->
    if ConsonantCount > K_max ->
        CharL = array:get(Left, S_array),
        UpdatedConsonantCount = if not is_vowel(CharL) -> ConsonantCount - 1; true -> ConsonantCount end,
        shrink_consonant_window(S_array, K_max, Left + 1, UpdatedConsonantCount);
    true ->
        {Left, ConsonantCount}
    end.

find_min_last_vowel_idx(VowelLastSeen, LeftBoundary) ->
    MinIdx = -1,
    AllFound = true,
    {FinalAllFound, FinalMinIdx} = array:foldl(
        fun(LastIdx, {CurrentAllFound, CurrentMinIdx}) ->
            if LastIdx == -1 orelse LastIdx < LeftBoundary ->
                {false, CurrentMinIdx}; % Vowel not seen or seen before LeftBoundary (not in current window)
            CurrentMinIdx == -1 orelse LastIdx < CurrentMinIdx ->
                {CurrentAllFound, LastIdx}; % Update min index
            true ->
                {CurrentAllFound, CurrentMinIdx} % Keep current min index
            end
        end,
        {AllFound, MinIdx},
        VowelLastSeen
    ),
    {FinalAllFound, FinalMinIdx}.