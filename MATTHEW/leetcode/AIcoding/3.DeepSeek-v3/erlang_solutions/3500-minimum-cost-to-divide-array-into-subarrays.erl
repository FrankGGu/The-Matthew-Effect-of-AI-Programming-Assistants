-module(solution).
-export([min_cost/1]).

min_cost(Nums) ->
    {_, Cost} = lists:foldl(fun(Num, {PrevMax, Total}) ->
        NewMax = max(PrevMax, Num),
        {NewMax, Total + NewMax}
    end, {0, 0}, Nums),
    Cost.