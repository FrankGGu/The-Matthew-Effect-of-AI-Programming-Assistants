-module(solution).
-export([longest_str_chain/1]).

longest_str_chain(Words) ->
    Sorted = lists:sort(fun(A, B) -> length(A) =< length(B) end, Words),
    Map = maps:new(),
    Max = 1,
    {_, Result} = lists:foldl(fun(Word, {AccMap, AccMax}) ->
        CurrentLength = 1,
        NewMap = maps:put(Word, CurrentLength, AccMap),
        NewMax = AccMax,
        {NewMap1, NewMax1} = check_predecessors(Word, NewMap, NewMax),
        {NewMap1, max(NewMax1, AccMax)}
    end, {Map, Max}, Sorted),
    Result.

check_predecessors(Word, Map, Max) ->
    Len = length(Word),
    CurrentLength = maps:get(Word, Map),
    NewMax = Max,
    {NewMap, NewMax1} = lists:foldl(fun(I, {AccMap, AccMax}) ->
        Pred = string:substr(Word, 1, I - 1) ++ string:substr(Word, I + 1, Len - I),
        case maps:is_key(Pred, AccMap) of
            true ->
                PredLength = maps:get(Pred, AccMap),
                if
                    PredLength + 1 > CurrentLength ->
                        NewMap1 = maps:put(Word, PredLength + 1, AccMap),
                        {NewMap1, max(PredLength + 1, AccMax)};
                    true ->
                        {AccMap, AccMax}
                end;
            false ->
                {AccMap, AccMax}
        end
    end, {Map, NewMax}, lists:seq(1, Len)),
    {NewMap, NewMax1}.