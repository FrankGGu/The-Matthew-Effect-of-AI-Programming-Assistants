-spec find_judge(N :: integer(), Trust :: [[integer()]]) -> integer().
find_judge(N, Trust) ->
    InDegree = lists:foldl(fun([_, B], Acc) -> 
                              maps:update_with(B, fun(V) -> V + 1 end, 1, Acc)
                           end, #{}, Trust),
    OutDegree = lists:foldl(fun([A, _], Acc) -> 
                               maps:update_with(A, fun(V) -> V + 1 end, 1, Acc)
                            end, #{}, Trust),
    Candidates = lists:filter(fun(X) -> 
                                 maps:get(X, InDegree, 0) =:= N - 1 andalso 
                                 not maps:is_key(X, OutDegree)
                              end, lists:seq(1, N)),
    case Candidates of
        [Judge] -> Judge;
        _ -> -1
    end.