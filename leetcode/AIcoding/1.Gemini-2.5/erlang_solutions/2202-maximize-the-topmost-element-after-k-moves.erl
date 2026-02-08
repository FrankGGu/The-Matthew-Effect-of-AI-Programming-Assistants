-module(solution).
-export([maximize_topmost_element/2]).

maximize_topmost_element(Nums, K) ->
    N = length(Nums),

    if N == 1 ->
        if K rem 2 == 0 ->
            hd(Nums);
        true ->
            -1
        end;
    true ->
        InitialMaxVal = -1,
        InitialMaxPrefix = -1,

        {FinalMaxVal, _} = lists:foldl(
            fun(I, {CurrentMaxVal, CurrentMaxPrefix}) ->
                Element = lists:nth(I + 1, Nums),
                NewMaxPrefix = max(CurrentMaxPrefix, Element),

                if K - (I + 2) >= 0 andalso (K - (I + 2)) rem 2 == 0 ->
                    {max(CurrentMaxVal, NewMaxPrefix), NewMaxPrefix};
                true ->
                    {CurrentMaxVal, NewMaxPrefix}
                end
            end,
            {InitialMaxVal, InitialMaxPrefix},
            lists:seq(0, min(N - 1, K - 1))
        ),

        Result = if K < N ->
                    max(FinalMaxVal, lists:nth(K + 1, Nums));
                 true ->
                    FinalMaxVal
                 end,
        Result
    end.