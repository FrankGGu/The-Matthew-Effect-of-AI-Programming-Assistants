-module(solution).
-export([reorderedPowerOf2/1]).

reorderedPowerOf2(N) ->
    SortedDigits = lists:sort(integer_to_list(N)),
    lists:any(fun(X) -> 
        lists:sort(integer_to_list(1 bsl X)) =:= SortedDigits 
    end, lists:seq(0, 30)).