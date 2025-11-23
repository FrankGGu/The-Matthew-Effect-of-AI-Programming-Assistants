-module(solution).
-export([find_anagrams/2]).

-spec build_freq_map(list()) -> map().
build_freq_map(Chars) ->
    lists:foldl(fun(C, Map) ->
        maps:update_with(C, fun(V) -> V + 1 end, 1, Map)
    end, #{}, Chars).

-spec find_anagrams(string(), string()) -> list(integer()).
find_anagrams(S, P) ->
    LenS = length(S),
    LenP = length(P),

    % If P is longer than S, no anagrams can exist.
    if LenP > LenS ->
        [];
    true ->
        PFreq = build_freq_map(P),

        % Get the initial window (first LenP characters of S)
        % and the rest of S after this window.
        {InitialWindowChars, S_after_initial_window} = lists:split(LenP, S),
        CurrentSFreq = build_freq_map(InitialWindowChars),

        % Initialize result list (built in reverse for efficiency)
        Acc = if CurrentSFreq == PFreq -> [0]; true -> [] end,

        % Start sliding window.
        % `S_from_prev_start` is the part of S starting from `Idx-1`. Its head is `S[Idx-1]`.
        % `S_from_prev_end_plus_1` is the part of S starting from `Idx-1 + LenP`. Its head is `S[Idx-1 + LenP]`.
        ResultReversed = slide_window(1, S, S_after_initial_window, LenP, PFreq, CurrentSFreq, Acc, LenS),
        lists:reverse(ResultReversed)
    end.

-spec slide_window(integer(), string(), string(), integer(), map(), map(), list(integer()), integer()) -> list(integer()).
slide_window(Idx, [CharToRemove | RestS_from_prev_start], [CharToAdd | RestS_from_prev_end_plus_1], LenP, PFreq, PrevSFreq, AccResult, LenS)
  when Idx =< LenS - LenP ->
    % Update the frequency map for the current window (starting at Idx)
    UpdatedSFreq1 = maps:update_with(CharToRemove, fun(V) -> V - 1 end, PrevSFreq),
    UpdatedSFreq = maps:update_with(CharToAdd, fun(V) -> V + 1 end, 1, UpdatedSFreq1),

    % Check if the current window is an anagram
    NewAccResult = if UpdatedSFreq == PFreq -> [Idx | AccResult]; true -> AccResult end,

    % Recurse for the next window
    slide_window(Idx + 1, RestS_from_prev_start, RestS_from_prev_end_plus_1, LenP, PFreq, UpdatedSFreq, NewAccResult, LenS);
slide_window(_Idx, _S_from_prev_start, _S_from_prev_end_plus_1, _LenP, _PFreq, _PrevSFreq, AccResult, _LenS) ->
    AccResult.