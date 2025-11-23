-module(solution).
-export([count_elements_with_strictly_smaller_and_greater_elements/1]).

count_elements_with_strictly_smaller_and_greater_elements(Nums) ->
    case length(Nums) of
        Len when Len < 3 -> 0;
        _ ->
            Min = lists:min(Nums),
            Max = lists:max(Nums),
            lists:foldl(fun(E, Acc) ->
                            if E > Min andalso E < Max -> Acc + 1;
                               true -> Acc
                            end
                        end, 0, Nums)
    end.