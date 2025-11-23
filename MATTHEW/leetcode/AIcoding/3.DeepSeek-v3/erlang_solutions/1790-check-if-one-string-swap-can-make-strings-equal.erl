-spec are_almost_equal(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary()) -> boolean().
are_almost_equal(S1, S2) ->
    case S1 =:= S2 of
        true -> true;
        false ->
            case find_mismatches(S1, S2, [], 0) of
                {[A, B], 2} -> A =:= lists:reverse(B);
                _ -> false
            end
    end.

find_mismatches(<<>>, <<>>, Mismatches, Count) -> {Mismatches, Count};
find_mismatches(<<C1, Rest1/binary>>, <<C2, Rest2/binary>>, Mismatches, Count) ->
    case C1 =:= C2 of
        true -> find_mismatches(Rest1, Rest2, Mismatches, Count);
        false -> find_mismatches(Rest1, Rest2, [[C1, C2] | Mismatches], Count + 1)
    end.