-module(frequency_tracker).
-export([init/0, add/2, deleteOne/2, hasFrequency/2]).

init() ->
    {#{}, #{}}.

add({FreqMap, CountMap}, Number) ->
    OldFreq = maps:get(Number, FreqMap, 0),
    NewFreq = OldFreq + 1,
    NewFreqMap = maps:put(Number, NewFreq, FreqMap),
    NewCountMap1 = case OldFreq of
        0 -> CountMap;
        _ -> 
            OldCount = maps:get(OldFreq, CountMap, 0),
            case OldCount - 1 of
                0 -> maps:remove(OldFreq, CountMap);
                N -> maps:put(OldFreq, N, CountMap)
            end
    end,
    NewCount = maps:get(NewFreq, NewCountMap1, 0),
    NewCountMap2 = maps:put(NewFreq, NewCount + 1, NewCountMap1),
    {NewFreqMap, NewCountMap2}.

deleteOne({FreqMap, CountMap}, Number) ->
    case maps:is_key(Number, FreqMap) of
        false -> {FreqMap, CountMap};
        true ->
            OldFreq = maps:get(Number, FreqMap),
            NewFreq = OldFreq - 1,
            NewFreqMap = case NewFreq of
                0 -> maps:remove(Number, FreqMap);
                _ -> maps:put(Number, NewFreq, FreqMap)
            end,
            NewCountMap1 = case OldFreq of
                0 -> CountMap;
                _ -> 
                    OldCount = maps:get(OldFreq, CountMap, 0),
                    case OldCount - 1 of
                        0 -> maps:remove(OldFreq, CountMap);
                        N -> maps:put(OldFreq, N, CountMap)
                    end
            end,
            NewCountMap2 = case NewFreq of
                0 -> NewCountMap1;
                _ -> 
                    NewCount = maps:get(NewFreq, NewCountMap1, 0),
                    maps:put(NewFreq, NewCount + 1, NewCountMap1)
            end,
            {NewFreqMap, NewCountMap2}
    end.

hasFrequency({_FreqMap, CountMap}, Frequency) ->
    maps:is_key(Frequency, CountMap).