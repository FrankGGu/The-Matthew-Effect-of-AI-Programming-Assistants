-module(solution).
-export([countOfPairs/3]).

countOfPairs(N, X, Y) ->
    {X_val, Y_val} = if X < Y -> {X, Y};
                       true -> {Y, X}
                     end,

    Ans = array:new([{fixed, true}, {size, N}, {default, 0}]),

    lists:foldl(fun(I, CurrentAns) ->
        lists:foldl(fun(J, InnerAns) ->
            D1 = J - I,
            D2 = abs(I - X_val) + 1 + abs(J - Y_val),
            D3 = abs(I - Y_val) + 1 + abs(J - X_val),

            MinDist = min(D1, min(D2, D3)),

            array:set(MinDist - 1, array:get(MinDist - 1, InnerAns) + 1, InnerAns)
        end, CurrentAns, lists:seq(I + 1, N))
    end, Ans, lists:seq(1, N - 1)),

    array:to_list(Ans).