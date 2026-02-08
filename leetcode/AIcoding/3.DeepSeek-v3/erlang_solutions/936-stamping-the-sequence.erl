-spec moves_to_stamp(Stamp :: unicode:unicode_binary(), Target :: unicode:unicode_binary()) -> [integer()].
moves_to_stamp(Stamp, Target) ->
    S = binary_to_list(Stamp),
    T = binary_to_list(Target),
    LenS = length(S),
    LenT = length(T),
    Res = [],
    solve(T, S, LenT, LenS, Res).

solve(T, _, LenT, _, Res) when T == lists:duplicate(LenT, $?) ->
    lists:reverse(Res);
solve(T, S, LenT, LenS, Res) ->
    case find_stamp(T, S, LenT, LenS) of
        -1 ->
            [];
        Pos ->
            NewT = stamp(T, S, Pos, LenS),
            solve(NewT, S, LenT, LenS, [Pos | Res])
    end.

find_stamp(T, S, LenT, LenS) ->
    find_stamp(T, S, LenT, LenS, 0).

find_stamp(T, S, LenT, LenS, Start) when Start + LenS =< LenT ->
    case match(T, S, Start, LenS) of
        true ->
            Start;
        false ->
            find_stamp(T, S, LenT, LenS, Start + 1)
    end;
find_stamp(_, _, _, _, _) ->
    -1.

match(T, S, Start, LenS) ->
    match(T, S, Start, LenS, 0, false).

match(T, S, Start, LenS, I, HasNonWild) when I < LenS ->
    TChar = lists:nth(Start + I + 1, T),
    SChar = lists:nth(I + 1, S),
    if
        TChar == $? ->
            match(T, S, Start, LenS, I + 1, HasNonWild);
        TChar == SChar ->
            match(T, S, Start, LenS, I + 1, true);
        true ->
            false
    end;
match(_, _, _, _, _, HasNonWild) ->
    HasNonWild.

stamp(T, S, Pos, LenS) ->
    stamp(T, S, Pos, LenS, 0).

stamp(T, _, _, LenS, I) when I >= LenS ->
    T;
stamp(T, S, Pos, LenS, I) ->
    NewT = replace_char(T, Pos + I, $?),
    stamp(NewT, S, Pos, LenS, I + 1).

replace_char(List, Index, Char) ->
    {Prefix, [_ | Suffix]} = lists:split(Index, List),
    Prefix ++ [Char | Suffix].