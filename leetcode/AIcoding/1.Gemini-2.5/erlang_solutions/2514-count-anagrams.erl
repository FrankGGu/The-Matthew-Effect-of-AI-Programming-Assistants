-module(solution).
-export([countAnagrams/2]).

create_freq_map_map(Str) ->
    lists:foldl(fun(Char, Map) ->
                    maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Map)
                end, #{}, Str).

countAnagrams(S, P) ->
    LenS = length(S),
    LenP = length(P),

    if LenP == 0 ->
        0;
       LenP > LenS -> 0;
       true ->
            P_freq = create_freq_map_map(P),

            InitialWindowChars = lists:sublist(S, LenP),
            InitialWindowFreq = create_freq_map_map(InitialWindowChars),
            InitialWindowQueue = lists:foldl(fun(Char, Q) -> queue:in(Char, Q) end, queue:new(), InitialWindowChars),

            countAnagrams_slide_map_queue(lists:nthtail(LenP, S), InitialWindowQueue, InitialWindowFreq, P_freq, 0)
    end.

countAnagrams_slide_map_queue(RemainingS, CurrentWindowQueue, CurrentWindowFreq, P_freq, Count) ->
    NewCount =
        if CurrentWindowFreq == P_freq -> Count + 1;
           true -> Count
        end,

    if RemainingS == [] -> NewCount;
       true ->
            {value, CharToRemove, QueueAfterRemove} = queue:out(CurrentWindowQueue),
            FreqAfterRemove = maps:update_with(CharToRemove, fun(C) -> C - 1 end, 0, CurrentWindowFreq),

            FreqAfterRemoveCleaned =
                case maps:get(CharToRemove, FreqAfterRemove) of
                    0 -> maps:remove(CharToRemove, FreqAfterRemove);
                    _ -> FreqAfterRemove
                end,

            [CharToAdd | RestS] = RemainingS,
            QueueAfterAdd = queue:in(CharToAdd, QueueAfterRemove),
            FreqAfterAdd = maps:update_with(CharToAdd, fun(C) -> C + 1 end, 1, FreqAfterRemoveCleaned),

            countAnagrams_slide_map_queue(RestS, QueueAfterAdd, FreqAfterAdd, P_freq, NewCount)
    end.