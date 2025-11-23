-module(remove_letter_to_equalize_frequency).
-export([equalizeFrequency/1]).

equalizeFrequency(S) ->
    Count = lists:foldl(fun(C, Acc) -> dict:update_counter(C, 1, Acc) end, dict:new(), S),
    Keys = dict:keys(Count),
    lists:all(fun(K) -> 
        lists:member(dict:fetch(K, Count) - 1, [dict:fetch(L, Count) || L <- Keys -- [K]])
    end, Keys).

isAllEqualAfterRemoval(FreqMap, Key) ->
    Freq = dict:fetch(Key, FreqMap),
    NewFreq = Freq - 1,
    lists:all(fun(K) -> 
        case K of
            Key -> NewFreq;
            _ -> dict:fetch(K, FreqMap)
        end
    end, dict:keys(FreqMap)) == lists:usort(lists:map(fun(K) -> 
        case K of
            Key -> NewFreq;
            _ -> dict:fetch(K, FreqMap)
        end
    end, dict:keys(FreqMap))).