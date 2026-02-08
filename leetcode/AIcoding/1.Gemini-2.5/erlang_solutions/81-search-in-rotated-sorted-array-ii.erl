-module(solution).
-export([search/2]).

search(Nums, Target) ->
    Arr = array:from_list(Nums),
    search_recursive(Arr, Target, 0, array:size(Arr) - 1).

search_recursive(Arr, Target, Low, High) when Low > High ->
    false;
search_recursive(Arr, Target, Low, High) ->
    Mid = Low + (High - Low) div 2,
    NumMid = array:get(Mid, Arr),

    if
        NumMid == Target ->
            true;
        true ->
            NumLow = array:get(Low, Arr),
            NumHigh = array:get(High, Arr),

            if
                NumLow == NumMid andalso NumMid == NumHigh ->
                    search_recursive(Arr, Target, Low + 1, High - 1);
                NumLow =< NumMid ->
                    if
                        Target >= NumLow andalso Target < NumMid ->
                            search_recursive(Arr, Target, Low, Mid - 1);
                        true ->
                            search_recursive(Arr, Target, Mid + 1, High)
                    end;
                true ->
                    if
                        Target > NumMid andalso Target =< NumHigh ->
                            search_recursive(Arr, Target, Mid + 1, High);
                        true ->
                            search_recursive(Arr, Target, Low, Mid - 1)
                    end
            end
    end.