-module(solution).
-export([powerful_integers/3]).

powerful_integers(X, Y, B) ->
    MaxX = if X > 1 -> math:log(B) / math:log(X); true -> 1 end,
    MaxY = if Y > 1 -> math:log(B) / math:log(Y); true -> 1 end,
    Sets = sets:new(),
    lists:foreach(fun(XPow) ->
        lists:foreach(fun(YPow) ->
            PInt = XPow + YPow,
            if PInt <= B -> Sets = sets:add(PInt, Sets) end
        end, [lists:foldl(fun(_, Acc) -> Acc * Y end, 1, lists:seq(0, MaxY))]),
    end, [lists:foldl(fun(_, Acc) -> Acc * X end, 1, lists:seq(0, MaxX))]),
    sets:size(Sets).