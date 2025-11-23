-spec minimum_bitwise_array(N :: integer(), X :: integer()) -> [integer()].
minimum_bitwise_array(N, X) ->
    Res = lists:seq(0, N - 1),
    case X of
        0 -> Res;
        _ ->
            case X >= N of
                true -> [X | Res];
                false ->
                    case lists:member(X, Res) of
                        true -> Res;
                        false -> [X | Res]
                    end
            end
    end.