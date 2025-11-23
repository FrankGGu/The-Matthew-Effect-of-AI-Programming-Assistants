-module(solution).
-export([find_longest_substring/1]).

find_longest_substring(S) ->
    Vowels = [$.a, $.e, $.i, $.o, $.u],
    Map = lists:foldl(fun(C, Acc) -> maps:put(C, 0, Acc) end, #{}, Vowels),
    State = {0, Map},
    find_longest_substring(S, 0, State, 0, #{}).

find_longest_substring([], _, _, Max, _) ->
    Max;

find_longest_substring([C | T], Index, {Count, VowelMap}, Max, Seen) ->
    case lists:member(C, [$.a, $.e, $.i, $.o, $.u]) of
        true ->
            NewVowelMap = maps:update(C, maps:get(C, VowelMap) + 1, VowelMap),
            CurrentCount = Count,
            NewCount = if (maps:get(C, NewVowelMap) rem 2 == 0) -> CurrentCount + 1; true -> CurrentCount end,
            Key = {NewVowelMap},
            case maps:find(Key, Seen) of
                {ok, PrevIndex} -> 
                    Max1 = max(Max, Index - PrevIndex),
                    find_longest_substring(T, Index + 1, {NewCount, NewVowelMap}, Max1, Seen);
                error ->
                    NewSeen = maps:put(Key, Index, Seen),
                    find_longest_substring(T, Index + 1, {NewCount, NewVowelMap}, Max, NewSeen)
            end;
        false ->
            NewVowelMap = VowelMap,
            NewCount = Count,
            Key = {NewVowelMap},
            case maps:find(Key, Seen) of
                {ok, PrevIndex} -> 
                    Max1 = max(Max, Index - PrevIndex),
                    find_longest_substring(T, Index + 1, {NewCount, NewVowelMap}, Max1, Seen);
                error ->
                    NewSeen = maps:put(Key, Index, Seen),
                    find_longest_substring(T, Index + 1, {NewCount, NewVowelMap}, Max, NewSeen)
            end
    end.