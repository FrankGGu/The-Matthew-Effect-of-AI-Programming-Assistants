-module(solution).
-export([fill_missing_data/1]).

fill_missing_data(Nums) ->
    {Sum, Count} = lists:foldl(
        fun(X, {AccSum, AccCount}) ->
            if
                X =/= 0 -> {AccSum + X, AccCount + 1};
                true -> {AccSum, AccCount}
            end
        end,
        {0, 0},
        Nums
    ),

    Average = if
        Count > 0 -> Sum / Count;
        true -> 0.0
    end,

    lists:map(
        fun(X) ->
            if
                X =:= 0 -> Average;
                true -> X
            end
        end,
        Nums
    ).