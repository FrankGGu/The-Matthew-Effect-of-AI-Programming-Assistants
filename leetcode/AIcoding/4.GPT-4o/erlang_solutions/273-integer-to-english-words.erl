-spec number_to_words(Num :: integer()) -> unicode:unicode_binary().
number_to_words(Num) when Num == 0 -> "Zero";
number_to_words(Num) ->
    number_to_words(Num, []).

number_to_words(0, Words) -> 
    lists:reverse(Words);
number_to_words(Num, Words) ->
    case Num rem 1000 of
        0 -> number_to_words(Num div 1000, Words);
        Remainder -> 
            number_to_words(Num div 1000, 
                [convert_chunk(Remainder) | Words])
    end.

convert_chunk(0) -> "";
convert_chunk(Num) when Num < 20 -> 
    lists:nth(Num + 1, ["", "One", "Two", "Three", "Four", "Five", 
                         "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", 
                         "Twelve", "Thirteen", "Fourteen", "Fifteen", 
                         "Sixteen", "Seventeen", "Eighteen", "Nineteen"]);
convert_chunk(Num) when Num < 100 -> 
    lists:nth((Num div 10) + 1, ["", "", "Twenty", "Thirty", "Forty", 
                                 "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"]) 
    ++ " " ++ convert_chunk(Num rem 10);
convert_chunk(Num) -> 
    convert_chunk(Num div 100) ++ " Hundred " ++ convert_chunk(Num rem 100).
