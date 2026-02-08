-module(solution).
-export([findNumberOfLIS/1]).

findNumberOfLIS(Nums) ->
    N = length(Nums),
    if N == 0 -> 0;
       true -> solve(Nums, N)
    end.

solve(Nums, N) ->
    NumsArray = array:from_list(Nums),

    InitialDPArray = array:from_list(lists:duplicate(N, {1, 1})),

    DPArray = lists:foldl(
        fun(I, CurrentDPArray) ->
            NumI = array:get(I, NumsArray),

            {CurrentLenI, CurrentCountI} = array:get(I, CurrentDPArray),

            {NewLenI, NewCountI} = lists:foldl(
                fun(J, {AccLenI, AccCountI}) ->
                    NumJ = array:get(J, NumsArray),
                    if
                        NumI > NumJ ->
                            {LenJ, CountJ} = array:get(J, CurrentDPArray),
                            if
                                LenJ + 1 > AccLenI ->
                                    {LenJ + 1, CountJ};
                                LenJ + 1 == AccLenI ->
                                    {AccLenI, AccCountI + CountJ};
                                true ->
                                    {AccLenI, AccCountI}
                            end;
                        true ->
                            {AccLenI, AccCountI}
                    end
                end,
                {CurrentLenI, CurrentCountI},
                lists:seq(0, I - 1)
            ),

            array:set(I, {NewLenI, NewCountI}, CurrentDPArray)
        end,
        InitialDPArray,
        lists:seq(0, N - 1)
    ),

    DPList = array:to_list(DPArray),

    MaxLen = lists:foldl(
        fun({Len, _Count}, AccMaxLen) -> max(Len, AccMaxLen) end,
        0,
        DPList
    ),

    Result = lists:foldl(
        fun({Len, Count}, AccSum) ->
            if
                Len == MaxLen ->
                    AccSum + Count;
                true ->
                    AccSum
            end
        end,
        0,
        DPList
    ),
    Result.