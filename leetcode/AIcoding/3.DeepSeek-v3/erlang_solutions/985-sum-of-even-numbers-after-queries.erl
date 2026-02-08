-spec sum_even_after_queries(Nums :: [integer()], Queries :: [[integer()]]) -> [integer()].
sum_even_after_queries(Nums, Queries) ->
    InitialSum = lists:sum([X || X <- Nums, X rem 2 == 0]),
    process_queries(Nums, Queries, InitialSum, []).

process_queries(_, [], _, Acc) -> lists:reverse(Acc);
process_queries(Nums, [[Val, Idx] | Rest], Sum, Acc) ->
    OldVal = lists:nth(Idx + 1, Nums),
    NewVal = OldVal + Val,
    NewNums = replace_nth(Idx + 1, NewVal, Nums),
    NewSum = case OldVal rem 2 == 0 of
        true -> Sum - OldVal;
        false -> Sum
    end,
    FinalSum = case NewVal rem 2 == 0 of
        true -> NewSum + NewVal;
        false -> NewSum
    end,
    process_queries(NewNums, Rest, FinalSum, [FinalSum | Acc]).

replace_nth(1, Val, [_ | T]) -> [Val | T];
replace_nth(N, Val, [H | T]) -> [H | replace_nth(N - 1, Val, T)].