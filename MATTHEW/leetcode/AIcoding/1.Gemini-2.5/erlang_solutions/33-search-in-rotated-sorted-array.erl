-module(solution).
-export([search/2]).

search(Nums, Target) ->
    Arr = array:from_list(Nums),
    Len = array:size(Arr),
    search_helper(Arr, Target, 0, Len - 1).

search_helper(_Arr, _Target, Low, High) when Low > High ->
    -1;
search_helper(Arr, Target, Low, High) ->
    Mid = Low + (High - Low) div 2,
    MidVal = array:get(Mid, Arr),

    if
        MidVal == Target ->
            Mid;
        true ->
            LowVal = array:get(Low, Arr),
            HighVal = array:get(High, Arr),

            if
                LowVal =< MidVal -> % Left half is sorted
                    if
                        LowVal =< Target andalso Target < MidVal ->
                            search_helper(Arr, Target, Low, Mid - 1);
                        true ->
                            search_helper(Arr, Target, Mid + 1, High)
                    end;
                true -> % Right half is sorted
                    if
                        MidVal < Target andalso Target =< HighVal ->
                            search_helper(Arr, Target, Mid + 1, High);
                        true ->
                            search_helper(Arr, Target, Low, Mid - 1)
                    end
            end
    end.