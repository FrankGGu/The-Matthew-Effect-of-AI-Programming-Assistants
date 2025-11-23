-module(solution).
-export([max_result/1]).

max_result(Nums) ->
    {Max, _} = lists:foldl(fun(X, {CurrentMax, PrevMax}) ->
        NewMax = max(CurrentMax, PrevMax + X),
        {NewMax, CurrentMax}
    end, {hd(Nums), 0}, tl(Nums)),
    Max.