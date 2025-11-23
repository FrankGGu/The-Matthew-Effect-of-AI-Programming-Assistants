-module(solution).
-export([reformat/1]).

reformat(S) ->
    {Letters, Digits} = lists:foldl(fun(Char, {LAcc, DAcc}) ->
                                        if
                                            Char >= $0 and Char =< $9 -> {LAcc, [Char | DAcc]};
                                            Char >= $a and Char =< $z -> {[Char | LAcc], DAcc};
                                            true -> {LAcc, DAcc}
                                        end
                                    end, {[], []}, S),

    LenL = length(Letters),
    LenD = length(Digits),

    AbsDiff = abs(LenL - LenD),

    if
        AbsDiff > 1 ->
            "";
        true ->
            RevLetters = lists:reverse(Letters),
            RevDigits = lists:reverse(Digits),

            if
                LenL >= LenD ->
                    interleave(RevLetters, RevDigits);
                true ->
                    interleave(RevDigits, RevLetters)
            end
    end.

interleave([], []) -> [];
interleave([H1 | T1], []) -> [H1 | interleave(T1, [])];
interleave([H1 | T1], [H2 | T2]) -> [H1, H2 | interleave(T1, T2)].