-module(shortest_completing_word).
-export([shortest_completing_word/2]).

shortest_completing_word(LicensePlate, Words) ->
    LicensePlateLower = string:lowercase(LicensePlate),
    LicensePlateCounts = get_letter_counts(LicensePlateLower),

    lists:foldl(
        fun(Word, Acc) ->
            WordLower = string:lowercase(Word),
            WordCounts = get_letter_counts(WordLower),

            case is_completing_word(LicensePlateCounts, WordCounts) of
                true ->
                    case Acc of
                        no_shortest -> Word;
                        ShortestWord ->
                            case length(Word) < length(ShortestWord) of
                                true -> Word;
                                false -> ShortestWord
                            end
                    end;
                false ->
                    Acc
            end
        end,
        no_shortest,
        Words
    ).

get_letter_counts(String) ->
    lists:foldl(
        fun(Char, Acc) ->
            case Char >= $a andalso Char =< $z of
                true ->
                    case maps:is_key(Char, Acc) of
                        true ->
                            maps:update(Char, maps:get(Char, Acc) + 1, Acc);
                        false ->
                            maps:put(Char, 1, Acc)
                    end;
                false ->
                    Acc
            end
        end,
        maps:new(),
        string:to_list(String)
    ).

is_completing_word(LicensePlateCounts, WordCounts) ->
    maps:all(
        fun(Char, Count) ->
            case maps:is_key(Char, WordCounts) of
                true ->
                    maps:get(Char, WordCounts) >= Count;
                false ->
                    false
            end
        end,
        LicensePlateCounts
    ).