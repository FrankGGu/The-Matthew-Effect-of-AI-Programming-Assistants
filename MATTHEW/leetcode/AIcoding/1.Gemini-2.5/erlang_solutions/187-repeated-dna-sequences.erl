-module(solution).
-export([repeated_dna_sequences/1]).

repeated_dna_sequences(S) ->
    Len = length(S),
    find_sequences(0, Len - 10, S, maps:new(), []).

find_sequences(Index, MaxIndex, S, CountsMap, ResultList) when Index =< MaxIndex ->
    Sub = lists:sublist(S, Index + 1, 10),
    Count = maps:get(Sub, CountsMap, 0),
    NewCount = Count + 1,
    NewCountsMap = maps:put(Sub, NewCount, CountsMap),
    NewResultList =
        if NewCount == 2 ->
                [Sub | ResultList];
            true ->
                ResultList
        end,
    find_sequences(Index + 1, MaxIndex, S, NewCountsMap, NewResultList);
find_sequences(_Index, _MaxIndex, _S, _CountsMap, ResultList) ->
    lists:reverse(ResultList).