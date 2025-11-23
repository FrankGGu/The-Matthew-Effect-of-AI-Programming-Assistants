-spec min_cost(binary()) -> integer().
min_cost(S) ->
    SList = binary_to_list(S),
    N = length(SList),
    Cost1 = lists:foldl(fun(I, Acc) ->
        if
            I > 0 andalso lists:nth(I, SList) =/= lists:nth(I + 1, SList) -> Acc + I;
            true -> Acc
        end
    end, 0, lists:seq(1, N - 1)),
    Cost2 = lists:foldl(fun(I, Acc) ->
        if
            I > 0 andalso lists:nth(N - I + 1, SList) =/= lists:nth(N - I, SList) -> Acc + I;
            true -> Acc
        end
    end, 0, lists:seq(1, N - 1)),
    min(Cost1, Cost2).