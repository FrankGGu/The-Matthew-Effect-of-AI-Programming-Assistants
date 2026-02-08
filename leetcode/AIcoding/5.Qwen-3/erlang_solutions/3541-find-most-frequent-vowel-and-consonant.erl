-module(solution).
-export([most_frequent/1]).

most_frequent(S) ->
    {Vowels, Consonants} = count_vowels_consonants(S),
    {VowelChar, VowelCount} = most_frequent_char(Vowels),
    {ConsonantChar, ConsonantCount} = most_frequent_char(Consonants),
    {VowelChar, VowelCount, ConsonantChar, ConsonantCount}.

count_vowels_consonants([]) -> {#{}, #{}};
count_vowels_consonants([C | T]) ->
    LowerC = string:to_lower([C]),
    case lists:member(LowerC, [$a, $e, $i, $o, $u]) of
        true ->
            {Vowels, Consonants} = count_vowels_consonants(T),
            Vowels2 = maps:update(LowerC, maps:get(LowerC, Vowels, 0) + 1, Vowels),
            {Vowels2, Consonants};
        false ->
            {Vowels, Consonants} = count_vowels_consonants(T),
            Consonants2 = maps:update(LowerC, maps:get(LowerC, Consonants, 0) + 1, Consonants),
            {Vowels, Consonants2}
    end.

most_frequent_char(Map) ->
    MostFreq = lists:foldl(fun({K, V}, {MaxK, MaxV}) ->
        if V > MaxV -> {K, V};
           true -> {MaxK, MaxV}
        end
    end, {none, 0}, maps:to_list(Map)),
    MostFreq.