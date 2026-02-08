-module(solution).
-export([get_max_repetitions/4]).

-spec get_max_repetitions(unicode:unicode_binary(), integer(), unicode:unicode_binary(), integer()) -> integer().
get_max_repetitions(S1, N1, S2, N2) ->
    %% Calculate the total length of both strings.
    Len1 = length(S1),
    Len2 = length(S2),
    
    %% Initialize counters.
    MaxCount = 0,
    %% Loop through the repetitions of S1.
    get_max_repetitions(S1, N1, S2, N2, Len1, Len2, MaxCount, 0).

%% Helper function to perform the actual logic.
-spec get_max_repetitions(unicode:unicode_binary(), integer(), unicode:unicode_binary(), integer(), integer(), integer(), integer(), integer()) -> integer().
get_max_repetitions(_, 0, _, _, _, _, MaxCount, _) -> MaxCount;
get_max_repetitions(S1, N1, S2, N2, Len1, Len2, MaxCount, Count) ->
    %% Check if S2 is a subsequence of S1.
    if
        subsequence(S1, S2) ->
            get_max_repetitions(S1, N1 - 1, S2, N2, Len1, Len2, MaxCount + 1, Count);
        true ->
            get_max_repetitions(S1, N1 - 1, S2, N2, Len1, Len2, MaxCount, Count)
    end.

%% Helper function to check if S2 is a subsequence of S1.
-spec subsequence(unicode:unicode_binary(), unicode:unicode_binary()) -> boolean().
subsequence([], _) -> true;
subsequence(_, []) -> false;
subsequence([H | T1], [H | T2]) -> subsequence(T1, T2);
subsequence([_ | T1], S2) -> subsequence(T1, S2).
