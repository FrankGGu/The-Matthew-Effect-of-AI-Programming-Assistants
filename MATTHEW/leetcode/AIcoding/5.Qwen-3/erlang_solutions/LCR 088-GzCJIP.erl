-module(min_cost_climb_stairs).
-export([cost/1]).

-cost(Costs) ->
    N = length(Costs),
    case N of
        0 -> 0;
        1 -> hd(Costs);
        _ ->
            A = 0,
            B = 0,
            lists:foldl(fun(C, Acc) ->
                                C1 = B + C,
                                C2 = A + C,
                                {C2, C1}
                            end, {A, B}, Costs)
    end.