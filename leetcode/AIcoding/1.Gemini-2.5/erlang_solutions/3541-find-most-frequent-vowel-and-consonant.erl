-module(solution).
-export([solve/1]).

is_letter(C) when C >= $a, C <= $z -> true;
is_letter(_) -> false.

is_vowel(C) when C == $a; C == $e; C == $i; C == $o; C == $u -> true;
is_vowel(_) -> false.

is_consonant(C) ->
    is_letter(C) andalso not is_vowel(C).

update_count(Char, Map) ->
    maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Map).

find_most_frequent(CountsMap) ->
    lists:foldl(fun({Char, Count}, {MaxCount, MaxChar}) ->
                    if
                        Count > MaxCount ->
                            {Count, Char};
                        Count == MaxCount andalso Char < MaxChar ->
                            {Count, Char};
                        true ->
                            {MaxCount, MaxChar}
                    end
                end, {0, 0}, maps:to_list(CountsMap)).

solve(S) ->
    InitialState = #{vowels => maps:new(), consonants => maps:new()},

    FinalState = lists:foldl(fun(Char, Acc) ->
                                 LowerChar = Char bor 32,
                                 if
                                     is_vowel(LowerChar) ->
                                         maps:update(vowels, update_count(LowerChar, maps:get(vowels, Acc)), Acc);
                                     is_consonant(LowerChar) ->
                                         maps:update(consonants, update_count(LowerChar, maps:get(consonants, Acc)), Acc);
                                     true ->
                                         Acc
                                 end
                             end, InitialState, S),

    VowelCounts = maps:get(vowels, FinalState),
    ConsonantCounts = maps:get(consonants, FinalState),

    {VowelMaxCount, VowelMaxChar} = find_most_frequent(VowelCounts),
    MostFrequentVowel = if
                            VowelMaxCount > 0 -> [VowelMaxChar];
                            true -> ""
                        end,

    {ConsonantMaxCount, ConsonantMaxChar} = find_most_frequent(ConsonantCounts),
    MostFrequentConsonant = if
                                ConsonantMaxCount > 0 -> [ConsonantMaxChar];
                                true -> ""
                            end,

    [MostFrequentVowel, MostFrequentConsonant].