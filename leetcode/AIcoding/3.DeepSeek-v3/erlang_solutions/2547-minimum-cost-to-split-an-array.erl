-module(min_cost_split_array).
-export([min_cost/2]).

min_cost(Nums, K) ->
    N = length(Nums),
    DP = array:new([{size, N + 1}, {default, 0}]),
    DP1 = array:set(0, 0, DP),
    {DP2, _} = lists:foldl(fun(I, {D, _}) ->
        lists:foldl(fun(J, {D0, Min}) ->
            Sub = lists:sublist(Nums, J + 1, I - J),
            {Freq, _} = lists:foldl(fun(X, {F, C}) ->
                case C:get(X) of
                    undefined -> {F + 1, C:put(X, 1)};
                    V -> {F, C:put(X, V + 1)}
                end
            end, {0, counters:new(1001)}, Sub),
            Cost = case Freq >= 2 of
                true -> K + Freq;
                false -> K + Freq
            end,
            NewVal = array:get(J, D0) + Cost,
            {D0, min(Min, NewVal)}
        end, {D, infinity}, lists:seq(0, I - 1)),
        NewD = array:set(I, Min, D),
        {NewD, Min}
    end, {DP1, 0}, lists:seq(1, N)),
    array:get(N, DP2).