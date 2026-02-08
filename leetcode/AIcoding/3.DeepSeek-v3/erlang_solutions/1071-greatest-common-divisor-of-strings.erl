-spec gcd_of_strings(Str1 :: unicode:unicode_binary(), Str2 :: unicode:unicode_binary()) -> unicode:unicode_binary().
gcd_of_strings(Str1, Str2) ->
    case Str1 ++ Str2 =:= Str2 ++ Str1 of
        false -> <<>>;
        true ->
            GCD = gcd(byte_size(Str1), byte_size(Str2)),
            binary:part(Str1, 0, GCD)
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).