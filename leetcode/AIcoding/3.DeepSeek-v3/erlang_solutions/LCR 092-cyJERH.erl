-spec min_flips(S :: unicode:unicode_binary()) -> integer().
min_flips(S) ->
    Bin = binary_to_list(S),
    N = length(Bin),
    Prefix0 = lists:foldl(fun(Ch, Acc) -> Acc + (if Ch =:= $1 -> 1; true -> 0 end) end, 0, Bin),
    MinFlips = Prefix0,
    {MinFlips1, _} = lists:foldl(fun(Ch, {MinFlipsAcc, Prefix0Acc}) ->
        Prefix0Acc1 = Prefix0Acc - (if Ch =:= $1 -> 1; true -> 0 end),
        Prefix1Acc1 = (N - length(Bin) - Prefix0Acc1),
        Flips = Prefix0Acc1 + Prefix1Acc1,
        {min(MinFlipsAcc, Flips), Prefix0Acc1}
    end, {MinFlips, Prefix0}, Bin),
    MinFlips1 = MinFlips1,
    MinFlips1.