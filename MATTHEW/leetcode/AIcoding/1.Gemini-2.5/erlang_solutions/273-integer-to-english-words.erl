-module(solution).
-export([numberToWords/1]).

numbers_1_19() ->
    #{
        1 => "One", 2 => "Two", 3 => "Three", 4 => "Four", 5 => "Five",
        6 => "Six", 7 => "Seven", 8 => "Eight", 9 => "Nine", 10 => "Ten",
        11 => "Eleven", 12 => "Twelve", 13 => "Thirteen", 14 => "Fourteen",
        15 => "Fifteen", 16 => "Sixteen", 17 => "Seventeen", 18 => "Eighteen",
        19 => "Nineteen"
    }.

tens() ->
    #{
        20 => "Twenty", 30 => "Thirty", 40 => "Forty", 50 => "Fifty",
        60 => "Sixty", 70 => "Seventy", 80 => "Eighty", 90 => "Ninety"
    }.

scales() ->
    ["Thousand", "Million", "Billion"].

to_words_less_than_1000(0) -> [];
to_words_less_than_1000(N) when N < 20 ->
    [maps:get(N, numbers_1_19())];
to_words_less_than_1000(N) when N < 100 ->
    TensVal = (N div 10) * 10,
    UnitsVal = N rem 10,
    case UnitsVal of
        0 -> [maps:get(TensVal, tens())];
        _ -> [maps:get(TensVal, tens()), maps:get(UnitsVal, numbers_1_19())]
    end;
to_words_less_than_1000(N) when N < 1000 ->
    HundredsVal = N div 100,
    Remainder = N rem 100,
    HundredsWords = [maps:get(HundredsVal, numbers_1_19()), "Hundred"],
    case Remainder of
        0 -> HundredsWords;
        _ -> HundredsWords ++ to_words_less_than_1000(Remainder)
    end.

numberToWords(0) -> "Zero";
numberToWords(Num) ->
    Scales = scales(),
    Words = convert_num(Num, 0, [], Scales),
    string:join(Words, " ").

convert_num(0, _ScaleIndex, AccWords, _Scales) -> AccWords;
convert_num(Num, ScaleIndex, AccWords, Scales) ->
    Remainder = Num rem 1000,
    NewNum = Num div 1000,

    NewAccWords = 
        case Remainder of
            0 -> AccWords;
            _ ->
                WordsForRemainder = to_words_less_than_1000(Remainder),
                case ScaleIndex of
                    0 -> WordsForRemainder ++ AccWords;
                    _ -> WordsForRemainder ++ [lists:nth(ScaleIndex, Scales)] ++ AccWords
                end
        end,

    convert_num(NewNum, ScaleIndex + 1, NewAccWords, Scales).