-module(solution).
-export([get_max_repetitions/4]).

get_max_repetitions(S1, N1, S2, N2) ->
    S1List = S1,
    S2List = S2,
    S1Len = length(S1List),
    S2Len = length(S2List),

    % If S1 is empty, S2 cannot be matched unless S2 is also empty, but problem constraints state S2Len >= 1.
    % So if S1Len is 0, result is 0.
    % Problem constraints: 1 <= len(s1), len(s2) <= 100. So S1Len, S2Len are always >= 1.
    % No need for explicit S1Len == 0 or S2Len == 0 checks based on constraints.

    % S2Ptr: current index in S2 (0-indexed)
    % S2TotalMatched: total number of full S2 repetitions matched so far

    % History: stores S2TotalMatched after each S1 repetition.
    %          history[i] is the total S2 matched after i+1 S1 repetitions.
    % S2PtrToS1RepIdxMap: maps S2Pointer (after an S1 repetition) to the S1 repetition index.
    %                     This helps detect cycles.

    % Initial state
    InitialS2Ptr = 0,
    InitialS2TotalMatched = 0,
    InitialHistory = [],
    InitialS2PtrToS1RepIdxMap = maps:new(),

    % Loop through N1 repetitions of S1
    get_max_repetitions_loop(0, N1, S1List, S2List, S2Len,
                             InitialS2Ptr, InitialS2TotalMatched,
                             InitialHistory, InitialS2PtrToS1RepIdxMap, N2).

get_max_repetitions_loop(S1RepIdx, N1, S1List, S2List, S2Len,
                         S2Ptr, S2TotalMatched,
                         History, S2PtrToS1RepIdxMap, N2) when S1RepIdx < N1 ->

    % Before processing current S1 repetition, check if the S2Ptr (after previous S1 rep) has been seen.
    % If S2Ptr is seen, it means we found a cycle.
    case maps:find(S2Ptr, S2PtrToS1RepIdxMap) of
        {ok, PrevS1RepIdx} ->
            % Cycle detected!
            % S2Ptr (current value) was previously seen after S1RepIdx = PrevS1RepIdx.

            % S2TotalMatched at the start of the cycle (after PrevS1RepIdx S1 repetitions).
            % lists:nth is 1-indexed, so PrevS1RepIdx + 1.
            PrefixS2Matched = lists:nth(PrevS1RepIdx + 1, History),

            CycleS1Reps = S1RepIdx - PrevS1RepIdx,
            CycleS2Matched = S2TotalMatched - PrefixS2Matched,

            % Number of S1 repetitions remaining after the current S1RepIdx.
            RemainingS1Reps = N1 - S1RepIdx,
            NumCycles = RemainingS1Reps div CycleS1Reps,

            TotalS2MatchedFromCycles = NumCycles * CycleS2Matched,

            S1RepsAfterCycles = RemainingS1Reps rem CycleS1Reps,

            % S2 matched in the partial cycle after full cycles.
            % This is the difference between S2TotalMatched after (PrevS1RepIdx + S1RepsAfterCycles)
            % and S2TotalMatched after PrevS1RepIdx.
            S2MatchedAfterCycles = 
                if S1RepsAfterCycles == 0 -> 0;
                   true -> lists:nth(PrevS1RepIdx + S1RepsAfterCycles + 1, History) - PrefixS2Matched
                end,

            FinalS2Matched = S2TotalMatched + TotalS2MatchedFromCycles + S2MatchedAfterCycles,
            FinalS2Matched div N2;

        _ ->
            % No cycle yet, record current S2Ptr and S1RepIdx.
            % The S2Ptr here is the state *before* processing the current S1 repetition.
            % We store the S1RepIdx that *starts* with this S2Ptr.
            NewS2PtrToS1RepIdxMap = maps:put(S2Ptr, S1RepIdx, S2PtrToS1RepIdxMap),

            % Simulate matching one S1 against S2.
            {NextS2Ptr, NextS2TotalMatched} = match_s1_against_s2(S1List, S2List, S2Len, S2Ptr, S2TotalMatched),

            % Add the S2TotalMatched after this S1 repetition to history.
            NewHistory = History ++ [NextS2TotalMatched],

            get_max_repetitions_loop(S1RepIdx + 1, N1, S1List, S2List, S2Len,
                                     NextS2Ptr, NextS2TotalMatched,
                                     NewHistory, NewS2PtrToS1RepIdxMap, N2)
    end;

get_max_repetitions_loop(_S1RepIdx, _N1, _S1List, _S2List, _S2Len,
                         _S2Ptr, S2TotalMatched,
                         _History, _S2PtrToS1RepIdxMap, N2) ->
    % Loop finished without detecting a cycle (N1 was small enough).
    S2TotalMatched div N2.

match_s1_against_s2([], _S2List, _S2Len, CurrentS2Ptr, CurrentS2TotalMatched) ->
    {CurrentS2Ptr, CurrentS2TotalMatched};
match_s1_against_s2([S1Char | RestS1], S2List, S2Len, CurrentS2Ptr, CurrentS2TotalMatched) ->
    % Check if S1Char matches the character at CurrentS2Ptr in S2List.
    % S2List is 1-indexed for lists:nth, CurrentS2Ptr is 0-indexed.
    S2Char = lists:nth(CurrentS2Ptr + 1, S2List),

    if
        S1Char == S2Char ->
            NewS2Ptr = (CurrentS2Ptr + 1) rem S2Len,
            NewS2TotalMatched = 
                if NewS2Ptr == 0 -> CurrentS2TotalMatched + 1;
                   true -> CurrentS2TotalMatched
                end,
            match_s1_against_s2(RestS1, S2List, S2Len, NewS2Ptr, NewS2TotalMatched);
        true ->
            % No match, S2Ptr doesn't advance, S2TotalMatched doesn't change.
            match_s1_against_s2(RestS1, S2List, S2Len, CurrentS2Ptr, CurrentS2TotalMatched)
    end.