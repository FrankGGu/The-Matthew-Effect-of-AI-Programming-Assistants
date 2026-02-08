-spec base_neg2(N :: integer()) -> unicode:unicode_binary().
base_neg2(N) when N == 0 -> <<"0">>;
base_neg2(N) ->
    base_neg2(N, []).

base_neg2(0, Acc) -> list_to_binary(lists:reverse(Acc));
base_neg2(N, Acc) ->
    Rem = N rem -2,
    case Rem < 0 of
        true -> base_neg2((N - Rem) div -2, [Rem + 2 + $0 | Acc]);
        false -> base_neg2(N div -2, [Rem + $0 | Acc])
    end.