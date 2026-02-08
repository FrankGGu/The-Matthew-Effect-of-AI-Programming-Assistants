-module(solution).
-export([store_water/2]).

store_water(Bucket, Vat) ->
    {Max, Sum} = lists:foldl(fun({B, V}, {MaxB, SumB}) -> 
        {max(MaxB, (V + B - 1) div B), SumB + B} 
    end, {0, 0}, lists:zip(Bucket, Vat)),
    if 
        Max == 0 -> 0;
        true ->
            lists:min([Max + lists:sum(lists:map(fun({B, V}) -> max(0, (V + Max - 1) div Max - B) end, lists:zip(Bucket, Vat))) | 
                [K + lists:sum(lists:map(fun({B, V}) -> max(0, (V + K - 1) div K - B) end, lists:zip(Bucket, Vat))) || K <- lists:seq(1, Max - 1)]])
    end.