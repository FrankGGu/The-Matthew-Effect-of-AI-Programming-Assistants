-spec last_substring(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
last_substring(S) ->
    N = byte_size(S),
    I = 0,
    J = 1,
    K = 0,
    {MaxI, _, _} = last_substring(S, N, I, J, K),
    binary:part(S, MaxI, N - MaxI).

last_substring(S, N, I, J, K) when I + K < N andalso J + K < N ->
    case binary:at(S, I + K) of
        C when C =:= binary:at(S, J + K) ->
            last_substring(S, N, I, J, K + 1);
        C when C > binary:at(S, J + K) ->
            last_substring(S, N, I, J + K + 1, 0);
        _ ->
            last_substring(S, N, J, I + K + 1, 0)
    end;
last_substring(_, _, I, J, _) when J >= byte_size(S) ->
    {I, J, 0};
last_substring(_, _, I, J, _) ->
    {J, I, 0}.