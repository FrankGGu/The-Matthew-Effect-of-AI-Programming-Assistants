-module(max_number_of_balloons).
-export([max_number_of_balloons/1]).

max_number_of_balloons(S) ->
    Count = lists:foldl(fun(Char, Acc) -> 
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
    end, maps:new(), S),
    Required = #{'b' => 1, 'a' => 1, 'l' => 2, 'o' => 2, 'n' => 1},
    lists:foldl(fun({Char, _}, Acc) ->
        case maps:get(Char, Required, 0) of
            0 -> Acc;
            R -> min(Acc, maps:get(Char, Count, 0) div R)
        end
    end, infinity, maps:to_list(Required)).