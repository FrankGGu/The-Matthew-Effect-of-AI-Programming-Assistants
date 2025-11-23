-spec longest_palindrome(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
longest_palindrome(S) ->
    case S of
        <<>> -> <<>>;
        _ ->
            {Start, Len} = find_longest_palindrome(S),
            binary:part(S, Start, Len)
    end.

find_longest_palindrome(S) ->
    N = byte_size(S),
    {Start, MaxLen} = lists:foldl(
        fun(I, {S0, L0}) ->
            {L1, R1} = expand_around_center(S, I, I),
            {L2, R2} = expand_around_center(S, I, I + 1),
            Len1 = R1 - L1 - 1,
            Len2 = R2 - L2 - 1,
            if
                Len1 > Len2 andalso Len1 > L0 -> {L1 + 1, Len1};
                Len2 > L0 -> {L2 + 1, Len2};
                true -> {S0, L0}
            end
        end,
        {0, 1},
        lists:seq(0, N - 1)
    ),
    {Start, MaxLen}.

expand_around_center(S, L, R) ->
    N = byte_size(S),
    if
        R >= N -> {L, R};
        true ->
            case binary:at(S, L) =:= binary:at(S, R) of
                true -> expand_around_center(S, L - 1, R + 1);
                false -> {L, R}
            end
    end.