-spec winner_square_game(N :: integer()) -> boolean().
winner_square_game(N) ->
    DP = array:new(N + 1, [{default, false}]),
    DP1 = array:set(0, false, DP),
    DP2 = array:set(1, true, DP1),
    DP3 = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(K, DPA) ->
            case K * K > I of
                true -> DPA;
                false ->
                    case array:get(I - K * K, DPA) of
                        false -> array:set(I, true, DPA);
                        true -> DPA
                    end
            end
        end, Acc, lists:seq(1, trunc(math:sqrt(I))))
    end, DP2, lists:seq(2, N)),
    array:get(N, DP3).