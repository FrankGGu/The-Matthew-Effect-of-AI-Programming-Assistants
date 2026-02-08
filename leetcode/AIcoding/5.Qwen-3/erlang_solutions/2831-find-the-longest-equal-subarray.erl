-module(solution).
-export([longest_equal_subarray/1]).

longest_equal_subarray(Arr) ->
    Map = maps:from_list([{Val, []} || Val <- lists:usort(Arr)]),
    lists:foldl(fun({Val, Index}, Acc) ->
        case maps:get(Val, Acc, []) of
            [] -> maps:put(Val, [Index], Acc);
            List -> maps:put(Val, [Index | List], Acc)
        end
    end, Map, lists:zip(Arr, lists:seq(0, length(Arr)-1))),
    Max = lists:foldl(fun({_, List}, Acc) ->
        case lists:reverse(List) of
            [H | T] -> 
                Diff = lists:last(T) - H,
                if Diff > Acc -> Diff; true -> Acc end;
            _ -> Acc
        end
    end, 0, maps:to_list(Map)),
    Max + 1.