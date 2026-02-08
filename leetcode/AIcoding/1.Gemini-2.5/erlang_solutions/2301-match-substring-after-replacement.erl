-module(solution).
-export([match_substring_after_replacement/3]).

-spec can_replace(char(), char(), map()) -> boolean().
can_replace(SChar, SubChar, MappingsMap) ->
    case maps:find(SChar, MappingsMap) of
        {ok, ReplacementsSet} ->
            %% If SChar has explicit mappings, check if SubChar is in its replacement set.
            sets:is_element(SubChar, ReplacementsSet);
        error ->
            %% If SChar is not in the map, it means it has no explicit mappings.
            %% In this case, it can only be replaced by itself.
            SChar == SubChar
    end.

-spec match_segment(string(), string(), map()) -> boolean().
match_segment(S_Segment, SubList, MappingsMap) ->
    case {S_Segment, SubList} of
        {[], []} ->
            %% Both segments are exhausted, meaning a full match.
            true;
        {[_|_], []} ->
            %% SubList is exhausted, meaning Sub has been fully matched.
            true;
        {[], [_|_]} ->
            %% S_Segment is exhausted but SubList is not, meaning no match.
            false;
        {[SH|ST], [SubH|SubT]} ->
            %% Compare current characters and recurse if they match.
            if can_replace(SH, SubH, MappingsMap) ->
                   match_segment(ST, SubT, MappingsMap);
               true ->
                   %% Current characters do not match, so this segment doesn't match.
                   false
            end
    end.

-spec match_substring_after_replacement(string(), string(), list(list(char()))) -> boolean().
match_substring_after_replacement(S, Sub, Mappings) ->
    SubLen = length(Sub),
    SLen = length(S),

    %% Pre-process the mappings into a map for efficient lookups.
    %% The map stores `#{ OriginalChar => set(ReplaceableChars) }`.
    %% Each character `C1` in a mapping `[C1, C2]` can always be replaced by itself,
    %% so `C1` is added to its own set.
    MappingsMap = lists:foldl(
        fun([C1, C2], AccMap) ->
            CurrentSet = case maps:find(C1, AccMap) of
                             {ok, Set} -> Set;
                             error -> sets:new()
                         end,
            %% Add both C1 (for self-replacement) and C2 to the set for C1.
            NewSet = sets:add_element(C1, sets:add_element(C2, CurrentSet)),
            maps:put(C1, NewSet, AccMap)
        end,
        maps:new(), %% Start with an empty map
        Mappings
    ),

    %% Iterate through all possible starting positions in S.
    %% StartIdx is 0-indexed.
    find_match(S, Sub, SubLen, SLen, MappingsMap, 0).

-spec find_match(string(), string(), integer(), integer(), map(), integer()) -> boolean().
find_match(S, Sub, SubLen, SLen, MappingsMap, StartIdx) ->
    if StartIdx + SubLen =< SLen ->
        %% If there are enough characters remaining in S for a potential match.
        %% Extract the segment of S to compare with Sub.
        %% lists:sublist is 1-indexed, so StartIdx + 1.
        S_Segment = lists:sublist(S, StartIdx + 1, SubLen),

        %% Check if this segment matches Sub.
        if match_segment(S_Segment, Sub, MappingsMap) ->
            true; %% Found a match!
        true ->
            %% No match at this position, try the next starting position.
            find_match(S, Sub, SubLen, SLen, MappingsMap, StartIdx + 1)
        end;
    true ->
        %% No more possible starting positions in S.
        false %% No match found in the entire string.
    end.