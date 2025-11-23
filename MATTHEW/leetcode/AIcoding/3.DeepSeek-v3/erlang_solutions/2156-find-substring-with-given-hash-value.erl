-spec sub_str_hash(S :: unicode:unicode_binary(), Power :: integer(), Modulo :: integer(), K :: integer(), HashValue :: integer()) -> unicode:unicode_binary().
sub_str_hash(S, Power, Modulo, K, HashValue) ->
    SList = binary_to_list(S),
    Len = length(SList),
    MaxPower = pow(Power, K - 1, Modulo),
    Hash = 0,
    Result = lists:foldl(fun(I, {CurrentHash, Res}) ->
        Char = lists:nth(I, SList),
        NewHash = (CurrentHash * Power + (Char - $a + 1)) rem Modulo,
        {NewHash, Res}
    end, {0, -1}, lists:seq(1, K)),
    InitialHash = element(1, Result),
    case InitialHash of
        HashValue -> 
            binary:part(S, 0, K);
        _ ->
            find_sub_str(SList, Power, Modulo, K, HashValue, InitialHash, MaxPower, Len)
    end.

find_sub_str(SList, Power, Modulo, K, HashValue, InitialHash, MaxPower, Len) ->
    lists:foldl(fun(I, {CurrentHash, Res}) ->
        OutChar = lists:nth(I, SList),
        InChar = lists:nth(I + K, SList),
        NewHash = (CurrentHash - (OutChar - $a + 1) * MaxPower) rem Modulo,
        PositiveHash = if NewHash < 0 -> NewHash + Modulo; true -> NewHash end,
        FinalHash = (PositiveHash * Power + (InChar - $a + 1)) rem Modulo,
        if 
            FinalHash =:= HashValue -> 
                {FinalHash, I + 1};
            true -> 
                {FinalHash, Res}
        end
    end, {InitialHash, -1}, lists:seq(1, Len - K)) of
        {_, -1} -> <<>>;
        {_, Pos} -> 
            binary:part(list_to_binary(SList), Pos - 1, K)
    end.

pow(_, 0, _) -> 1;
pow(Base, Exp, Mod) ->
    pow(Base, Exp, Mod, 1).

pow(Base, Exp, Mod, Acc) when Exp > 0 ->
    if 
        Exp band 1 =:= 1 ->
            pow((Base * Base) rem Mod, Exp bsr 1, Mod, (Acc * Base) rem Mod);
        true ->
            pow((Base * Base) rem Mod, Exp bsr 1, Mod, Acc)
    end;
pow(_, _, _, Acc) -> Acc.