-module(integer_to_english_words).
-export([number_to_words/1]).

number_to_words(Num) ->
    number_to_words_helper(Num).

number_to_words_helper(0) -> "Zero";
number_to_words_helper(Num) ->
    lists:trim(number_to_words_billion(Num)).

number_to_words_billion(Num) ->
    case Num div 1000000000 of
        0 -> number_to_words_million(Num rem 1000000000);
        Billion ->
            lists:concat([
                number_to_words_million(Billion),
                " Billion ",
                number_to_words_million(Num rem 1000000000)
            ])
    end.

number_to_words_million(Num) ->
    case Num div 1000000 of
        0 -> number_to_words_thousand(Num rem 1000000);
        Million ->
            lists:concat([
                number_to_words_thousand(Million),
                " Million ",
                number_to_words_thousand(Num rem 1000000)
            ])
    end.

number_to_words_thousand(Num) ->
    case Num div 1000 of
        0 -> number_to_words_hundred(Num rem 1000);
        Thousand ->
            lists:concat([
                number_to_words_hundred(Thousand),
                " Thousand ",
                number_to_words_hundred(Num rem 1000)
            ])
    end.

number_to_words_hundred(Num) ->
    case Num div 100 of
        0 -> number_to_words_less_than_hundred(Num rem 100);
        Hundred ->
            lists:concat([
                number_to_words_less_than_hundred(Hundred),
                " Hundred ",
                number_to_words_less_than_hundred(Num rem 100)
            ])
    end.

number_to_words_less_than_hundred(Num) ->
    case Num of
        0 -> "";
        1 -> "One";
        2 -> "Two";
        3 -> "Three";
        4 -> "Four";
        5 -> "Five";
        6 -> "Six";
        7 -> "Seven";
        8 -> "Eight";
        9 -> "Nine";
        10 -> "Ten";
        11 -> "Eleven";
        12 -> "Twelve";
        13 -> "Thirteen";
        14 -> "Fourteen";
        15 -> "Fifteen";
        16 -> "Sixteen";
        17 -> "Seventeen";
        18 -> "Eighteen";
        19 -> "Nineteen";
        _ ->
            Tens = Num div 10,
            Ones = Num rem 10,
            case Tens of
                2 -> lists:concat(["Twenty", if Ones > 0 -> " ", true -> "" end, number_to_words_less_than_hundred(Ones)]);
                3 -> lists:concat(["Thirty", if Ones > 0 -> " ", true -> "" end, number_to_words_less_than_hundred(Ones)]);
                4 -> lists:concat(["Forty", if Ones > 0 -> " ", true -> "" end, number_to_words_less_than_hundred(Ones)]);
                5 -> lists:concat(["Fifty", if Ones > 0 -> " ", true -> "" end, number_to_words_less_than_hundred(Ones)]);
                6 -> lists:concat(["Sixty", if Ones > 0 -> " ", true -> "" end, number_to_words_less_than_hundred(Ones)]);
                7 -> lists:concat(["Seventy", if Ones > 0 -> " ", true -> "" end, number_to_words_less_than_hundred(Ones)]);
                8 -> lists:concat(["Eighty", if Ones > 0 -> " ", true -> "" end, number_to_words_less_than_hundred(Ones)]);
                9 -> lists:concat(["Ninety", if Ones > 0 -> " ", true -> "" end, number_to_words_less_than_hundred(Ones)])
            end
    end.