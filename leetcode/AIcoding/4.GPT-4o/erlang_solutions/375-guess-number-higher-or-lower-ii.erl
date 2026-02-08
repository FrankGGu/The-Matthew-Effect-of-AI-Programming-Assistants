-spec get_money_amount(N :: integer()) -> integer().
get_money_amount(N) ->
    lists:foldl(fun(X, Acc) -> 
                    lists:foldl(fun(Y, InnerAcc) -> 
                                    lists:append(InnerAcc, [{X, Y}])
                                end, [], lists:seq(X + 1, N)) 
                end, [], lists:seq(1, N)).
