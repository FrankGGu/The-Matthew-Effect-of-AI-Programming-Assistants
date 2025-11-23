-module(solution).
-export([colorCombination/1]).

colorCombination(ColorList) ->
    ColorCount = lists:foldl(fun(Color, Acc) -> 
        case maps:find(Color, Acc) of 
            {ok, Count} -> maps:put(Color, Count + 1, Acc); 
            _ -> maps:put(Color, 1, Acc) 
        end 
    end, #{}, ColorList),
    maps:fold(fun(_, Count, Acc) -> Acc + Count end, 0, ColorCount).