-spec gray_code(N :: integer()) -> [integer()].
gray_code(N) ->
    case N of
        0 -> [0];
        _ ->
            Prev = gray_code(N - 1),
            lists:append(Prev, [X + (1 bsl (N - 1)) || X <- lists:reverse(Prev)])
    end.