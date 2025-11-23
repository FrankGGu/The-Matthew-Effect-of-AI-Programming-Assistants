-spec reformat(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
reformat(S) ->
    Letters = [C || C <- S, C >= $a, C =< $z],
    Digits = [C || C <- S, C >= $0, C =< $9],
    LenL = length(Letters),
    LenD = length(Digits),
    if
        abs(LenL - LenD) > 1 -> <<>>;
        LenL > LenD -> interleave(Letters, Digits);
        true -> interleave(Digits, Letters)
    end.

interleave([], []) -> <<>>;
interleave([H1 | T1], []) -> <<H1, (interleave(T1, []))/binary>>;
interleave([], [H2 | T2]) -> <<H2, (interleave([], T2))/binary>>;
interleave([H1 | T1], [H2 | T2]) -> <<H1, H2, (interleave(T1, T2))/binary>>.