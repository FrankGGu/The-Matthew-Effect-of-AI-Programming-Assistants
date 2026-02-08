-module(solution).
-export([most_frequent/1]).

most_frequent(S) ->
    Vowels = sets:from_list("aeiou"),
    LowerS = string:to_lower(S),
    {VowelCounts, ConsonantCounts} = count_chars(LowerS, Vowels, #{}, #{}),
    MaxVowel = find_max(VowelCounts),
    MaxConsonant = find_max(ConsonantCounts),
    [MaxVowel, MaxConsonant].

count_chars([], _, VowelCounts, ConsonantCounts) ->
    {VowelCounts, ConsonantCounts};
count_chars([Char | Rest], Vowels, VowelCounts, ConsonantCounts) ->
    case $a =< Char andalso Char =< $z of
        true ->
            case sets:is_element(Char, Vowels) of
                true ->
                    NewVowelCounts = maps:update_with(Char, fun(V) -> V + 1 end, 1, VowelCounts),
                    count_chars(Rest, Vowels, NewVowelCounts, ConsonantCounts);
                false ->
                    NewConsonantCounts = maps:update_with(Char, fun(V) -> V + 1 end, 1, ConsonantCounts),
                    count_chars(Rest, Vowels, VowelCounts, NewConsonantCounts)
            end;
        false ->
            count_chars(Rest, Vowels, VowelCounts, ConsonantCounts)
    end.

find_max(Counts) ->
    case maps:size(Counts) of
        0 -> "";
        _ ->
            {Char, _} = lists:last(lists:keysort(1, maps:to_list(Counts))),
            [Char]
    end.