-module(solution).
-export([original_digits/1]).

-spec original_digits(binary()) -> binary().
original_digits(S) ->
    Letters = unicode:characters_to_list(S),
    FreqMap = lists:foldl(fun(C, Acc) ->
        maps:update_with(C, fun(N) -> N + 1 end, 1, Acc)
    end, #{}, Letters),

    DigitsCount = get_digits_count(FreqMap),

    DigitsList = lists:append(
        [lists:duplicate(maps:get(D, DigitsCount, 0), D) || D <- lists:seq(0, 9)]
    ),
    Result = [D + $0 || D <- DigitsList],
    unicode:characters_to_binary(Result).

get_digits_count(Freq) ->
    Zero = get_letter(Freq, $z),
    Two  = get_letter(Freq, $w),
    Four = get_letter(Freq, $u),
    Six  = get_letter(Freq, $x),
    Eight = get_letter(Freq, $g),

    Three = get_letter(Freq, $h) - Eight,
    Five  = get_letter(Freq, $f) - Four,
    Seven = get_letter(Freq, $s) - Six,
    One   = get_letter(Freq, $o) - Zero - Two - Four,
    Nine  = get_letter(Freq, $i) - Five - Six - Eight,

    #{
        0 => Zero,
        1 => One,
        2 => Two,
        3 => Three,
        4 => Four,
        5 => Five,
        6 => Six,
        7 => Seven,
        8 => Eight,
        9 => Nine
    }.

get_letter(FreqMap, Char) ->
    maps:get(Char, FreqMap, 0).
