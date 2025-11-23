-module(tallest_billiboard).
-export([tallest_billboard/1]).

tallest_billboard(Choices) ->
    Max = lists:max(Choices),
    Size = length(Choices),
    DP = array:new([{size, Max * 2 + 1}, {default, -1}]),
    array:set(Max, 0, DP),
    lists:foldl(fun(C, Acc) ->
        NewDP = array:new([{size, Max * 2 + 1}, {default, -1}]),
        lists:foreach(fun(I) ->
            if
                array:get(I, Acc) /= -1 ->
                    Val = array:get(I, Acc),
                    array:set(I + C, max(array:get(I + C, NewDP), Val + C), NewDP),
                    array:set(I - C, max(array:get(I - C, NewDP), Val), NewDP);
                true -> ok
            end
        end, lists:seq(0, Max * 2)),
        NewDP
    end, DP, Choices),
    array:get(Max, DP).