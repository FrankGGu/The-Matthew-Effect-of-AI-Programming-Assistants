-spec max_frequency_diff(Nums :: [integer()]) -> integer().
max_frequency_diff(Nums) ->
    FreqMap = lists:foldl(fun(N, Acc) -> 
                              maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) 
                          end, #{}, Nums),
    EvenFreq = [V || {_, V} <- maps:to_list(FreqMap), V rem 2 == 0],
    OddFreq = [V || {_, V} <- maps:to_list(FreqMap), V rem 2 =/= 0],
    case {EvenFreq, OddFreq} of
        {[], []} -> 0;
        {[], _} -> lists:max(OddFreq);
        {_, []} -> lists:max(EvenFreq);
        _ -> abs(lists:max(EvenFreq) - lists:max(OddFreq))
    end.