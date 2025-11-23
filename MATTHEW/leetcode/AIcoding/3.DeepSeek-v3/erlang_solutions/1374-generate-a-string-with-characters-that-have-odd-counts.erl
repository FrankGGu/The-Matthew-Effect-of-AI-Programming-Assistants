-spec generate_the_string(N :: integer()) -> unicode:unicode_binary().
generate_the_string(N) ->
    case N rem 2 of
        1 -> binary:copy(<<"a">>, N);
        0 -> <<(binary:copy(<<"a">>, N - 1))/binary, "b">>
    end.