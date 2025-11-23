-spec good_indices(Nums :: [integer()], K :: integer()) -> [integer()].
good_indices(Nums, K) ->
    N = length(Nums),
    NonIncreasing = lists:duplicate(N, true),
    NonIncreasing1 = lists:foldl(fun(I, Acc) ->
        case I > 0 andalso lists:nth(I, Nums) =< lists:nth(I + 1, Nums) of
            true -> Acc;
            false -> lists:sublist(Acc, I - 1) ++ [false | lists:nthtail(I, Acc)]
        end
    end, NonIncreasing, lists:seq(1, N - 1)),
    NonIncreasing2 = lists:foldl(fun(I, Acc) ->
        case I > 0 andalso lists:nth(I, NonIncreasing1) andalso lists:nth(I + 1, NonIncreasing1) of
            true -> Acc;
            false -> lists:sublist(Acc, I - 1) ++ [false | lists:nthtail(I, Acc)]
        end
    end, NonIncreasing1, lists:seq(1, N - 1)),
    NonDecreasing = lists:duplicate(N, true),
    NonDecreasing1 = lists:foldl(fun(I, Acc) ->
        case I > 0 andalso lists:nth(I, Nums) >= lists:nth(I + 1, Nums) of
            true -> Acc;
            false -> lists:sublist(Acc, I - 1) ++ [false | lists:nthtail(I, Acc)]
        end
    end, NonDecreasing, lists:seq(1, N - 1)),
    NonDecreasing2 = lists:foldl(fun(I, Acc) ->
        case I > 0 andalso lists:nth(I, NonDecreasing1) andalso lists:nth(I + 1, NonDecreasing1) of
            true -> Acc;
            false -> lists:sublist(Acc, I - 1) ++ [false | lists:nthtail(I, Acc)]
        end
    end, NonDecreasing1, lists:seq(1, N - 1)),
    lists:filtermap(fun(I) ->
        if
            I > K andalso I =< N - K ->
                case lists:nth(I - K, NonIncreasing2) andalso lists:nth(I + K, NonDecreasing2) of
                    true -> {true, I};
                    false -> false
                end;
            true -> false
        end
    end, lists:seq(1, N)).