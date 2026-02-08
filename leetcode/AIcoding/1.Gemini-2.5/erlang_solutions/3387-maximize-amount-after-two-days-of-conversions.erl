-module(solution).
-export([maximize_amount/1]).

maximize_amount(Nums) ->
    InitialSum = lists:sum(Nums),
    MinVal = lists:min(Nums),

    if
        MinVal < 0 ->
            InitialSum - MinVal;
        true ->
            InitialSum
    end.