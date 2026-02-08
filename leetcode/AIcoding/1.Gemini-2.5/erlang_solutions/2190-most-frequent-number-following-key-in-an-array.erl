-module(solution).
-export([most_frequent_following_key/2]).

most_frequent_following_key(Nums, Key) ->
    FreqMap = count_frequencies(Nums, Key, #{}),
    find_max_freq(FreqMap).

count_frequencies([Key, Target | Rest], Key, FreqMap) ->
    NewFreq = maps:get(Target, FreqMap, 0) + 1,
    count_frequencies([Target | Rest], Key, maps:put(Target, NewFreq, FreqMap));
count_frequencies([_ | Rest], Key, FreqMap) ->
    count_frequencies(Rest, Key, FreqMap);
count_frequencies([], _, FreqMap) ->
    FreqMap.

find_max_freq(FreqMap) ->
    {MaxTarget, _MaxFreq} = maps:fold(fun(Target, Freq, {CurrentMaxTarget, CurrentMaxFreq}) ->
                                           if F > CurrentMaxFreq -> {Target, F};
                                              true -> {CurrentMaxTarget, CurrentMaxFreq}
                                           end
                                   end, {0, -1}, FreqMap),
    MaxTarget.