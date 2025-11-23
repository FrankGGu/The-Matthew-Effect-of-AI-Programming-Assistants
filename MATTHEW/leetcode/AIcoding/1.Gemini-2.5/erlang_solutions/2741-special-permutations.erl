-module(solution).
-export([specialPermutations/1]).

-include_lib("array/include/array.hrl").

specialPermutations(Nums) ->
    N = length(Nums),

    NumsArray = array:from_list(Nums),

    Solve = 
        fun Solve_Inner(Mask, LastIdx, Memo) ->
            case maps:find({Mask, LastIdx}, Memo) of
                {ok, Val} ->
                    {Val, Memo};
                _ ->
                    if Mask == (1 bsl LastIdx) ->
                        {1, maps:put({Mask, LastIdx}, 1, Memo)};
                    true ->
                        PrevMask = Mask bxor (1 bsl LastIdx),

                        NumLast = array:get(LastIdx, NumsArray),

                        {Sum, FinalMemoForThisCall} = lists:foldl(
                            fun(PrevIdx, {CurrentSum, CurrentMemo}) ->
                                if (PrevMask band (1 bsl PrevIdx)) /= 0 ->
                                    NumPrev = array:get(PrevIdx, NumsArray),

                                    if (NumLast rem NumPrev == 0) or (NumPrev rem NumLast == 0) ->
                                        {Count, UpdatedMemo} = Solve_Inner(PrevMask, PrevIdx, CurrentMemo),
                                        {CurrentSum + Count, UpdatedMemo};
                                    true ->
                                        {CurrentSum, CurrentMemo}
                                    end;
                                true ->
                                    {CurrentSum, CurrentMemo}
                                end
                            end,
                            {0, Memo},
                            lists:seq(0, N - 1)
                        ),

                        {Sum, maps:put({Mask, LastIdx}, Sum, FinalMemoForThisCall)}
                    end
            end
        end,

    InitialMemo = maps:new(),

    FullMask = (1 bsl N) - 1,

    {TotalSum, _FinalMemo} = lists:foldl(
        fun(LastIdx, {AccSum, AccMemo}) ->
            {Count, UpdatedMemo} = Solve_Inner(FullMask, LastIdx, AccMemo),
            {AccSum + Count, UpdatedMemo}
        end,
        {0, InitialMemo},
        lists:seq(0, N - 1)
    ),

    TotalSum.