-spec kth_factor(N :: integer(), K :: integer()) -> integer().
kth_factor(N, K) ->
    Factors = lists:filter(fun(X) -> N rem X =:= 0 end, lists:seq(1, N)),
    case length(Factors) >= K of
        true -> lists:nth(K, Factors);
        false -> -1
    end.