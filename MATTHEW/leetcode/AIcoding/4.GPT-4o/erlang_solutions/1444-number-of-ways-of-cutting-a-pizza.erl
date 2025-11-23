-module(solution).
-export([ways/3]).

ways(Pizza, K) ->
    Rows = length(Pizza),
    Cols = length(hd(Pizza)),
    PizzaMatrix = lists:map(fun(Row) -> lists:map(fun(X) -> if X =:= "." -> 0; true -> 1 end) end, Row) end, Pizza),
    PrefixSum = prefix_sum(PizzaMatrix),
    ways_helper(PrefixSum, K, 0, 0).

ways_helper(_, 1, R, C) -> 1;
ways_helper(PrefixSum, K, R, C) ->
    Count = 0,
    MaxRows = length(PrefixSum),
    MaxCols = length(hd(PrefixSum)),
    lists:foreach(fun({dr, dc}) -> 
        {NR, NC} = {R + dr, C + dc},
        if NR < MaxRows andalso NC < MaxCols andalso get_pizza_sum(PrefixSum, R, C, NR, NC) > 0 ->
            Count = Count + ways_helper(PrefixSum, K - 1, NR, NC)
        end
    end, [{1, 0}, {0, 1}, {1, 1}]),
    Count.

get_pizza_sum(PrefixSum, R1, C1, R2, C2) ->
    Total = PrefixSum(R2, C2),
    A = if R1 > 0 andalso C1 > 0 -> PrefixSum(R1 - 1, C1 - 1); true -> 0 end,
    B = if R1 > 0 -> PrefixSum(R1 - 1, C2); true -> 0 end,
    C = if C1 > 0 -> PrefixSum(R2, C1 - 1); true -> 0 end,
    Total - A - B + C.

prefix_sum(Pizza) ->
    {Rows, Cols} = {length(Pizza), length(hd(Pizza))},
    PrefixSum = lists:foldl(fun(Row, Acc) -> 
        lists:foldl(fun(Val, {SumRow, AccRow}) -> 
            NewSum = SumRow + Val,
            if Val > 0 -> {NewSum, AccRow ++ [NewSum]} ; true -> {NewSum, AccRow ++ [hd(AccRow)]} end
        end, {0, []}, Row)
    end, [], Pizza),
    lists:map(fun(X) -> lists:reverse(X) end, PrefixSum).