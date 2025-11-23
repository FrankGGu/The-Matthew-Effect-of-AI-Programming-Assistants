-spec partition(S :: unicode:unicode_binary()) -> [[unicode:unicode_binary()]].
partition(S) ->
    partition(S, [], []).

partition(<<>>, Current, Acc) ->
    [lists:reverse(Current) | Acc];
partition(S, Current, Acc) ->
    lists:foldl(
        fun(I, AccIn) ->
            Prefix = binary:part(S, 0, I),
            case is_palindrome(Prefix) of
                true ->
                    Rest = binary:part(S, I, byte_size(S) - I),
                    partition(Rest, [Prefix | Current], AccIn);
                false ->
                    AccIn
            end
        end,
        Acc,
        lists:seq(1, byte_size(S))
    ).

is_palindrome(S) ->
    S == binary:reverse(S).