-module(most_frequent_even_element).
-export([mostFrequentEven/1]).

mostFrequentEven(Nums) ->
    Count = lists:foldl(fun(N, Acc) ->
        case N rem 2 of
            0 -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc);
            _ -> Acc
        end
    end, #{}, Nums),
    lists:foldl(fun({K, V}, {MaxVal, MaxCount}) ->
        if
            V > MaxCount -> {K, V};
            V == MaxCount andalso K < MaxVal -> {K, V};
            true -> {MaxVal, MaxCount}
        end
    end, {undefined, 0}, maps:to_list(Count)).

mostFrequentEven(_) ->
    undefined.