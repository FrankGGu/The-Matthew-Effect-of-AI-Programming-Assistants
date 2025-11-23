-module(solution).
-export([character_replacement/2]).

-include_lib("stdlib/include/maps.hrl").

-spec character_replacement(binary(), integer()) -> integer().
character_replacement(S, K) ->
    character_replacement_loop(S, K, 0, 0, #{}, 0, 0).

character_replacement_loop(S, K, Start, End, CountMap, MaxFreq, MaxLen) ->
    case End < byte_size(S) of
        true ->
            <<_:Start/binary, C:8, _/binary>> = binary:part(S, {End, 1}),
            Char = C,
            NewCount = maps:get(Char, CountMap, 0) + 1,
            UpdatedCountMap = maps:put(Char, NewCount, CountMap),
            UpdatedMaxFreq = max(NewCount, MaxFreq),
            WindowSize = End - Start + 1,
            case WindowSize - UpdatedMaxFreq =< K of
                true ->
                    NewMaxLen = max(MaxLen, WindowSize),
                    character_replacement_loop(S, K, Start, End + 1, UpdatedCountMap, UpdatedMaxFreq, NewMaxLen);
                false ->
                    <<_:StartChar:8, _/binary>> = binary:part(S, {Start, 1}),
                    DecCount = maps:get(StartChar, UpdatedCountMap, 1) - 1,
                    CleanedMap = if DecCount =:= 0 -> maps:remove(StartChar, UpdatedCountMap);
                                   true -> maps:put(StartChar, DecCount, UpdatedCountMap) end,
                    character_replacement_loop(S, K, Start + 1, End + 1, CleanedMap, UpdatedMaxFreq, MaxLen)
            end;
        false ->
            MaxLen
    end.

max(A, B) when A >= B -> A;
max(_, B) -> B.
