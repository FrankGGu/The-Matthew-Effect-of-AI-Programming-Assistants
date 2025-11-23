-spec get_smallest_string(N :: integer(), K :: integer()) -> unicode:unicode_binary().
get_smallest_string(N, K) ->
    K1 = K - N,
    Zs = K1 div 25,
    Rem = K1 rem 25,
    case Zs of
        0 ->
            <<(Rem + $a), (lists:duplicate(N - 1, $a))/binary>>;
        _ when Zs == N ->
            <<(lists:duplicate(N, $z))/binary>>;
        _ ->
            <<(lists:duplicate(N - Zs - 1, $a))/binary, (Rem + $a), (lists:duplicate(Zs, $z))/binary>>
    end.