-module(solution).
-export([product_less_than_k/2]).

product_less_than_k(Nums, K) ->
    if
        K =< 1 -> 0;
        true ->
            Array = array:from_list(Nums),
            Length = array:size(Array),
            solve(Array, K, 0, 0, 1, 0, Length)
    end.

solve(Array, K, RightIndex, LeftIndex, CurrentProduct, CountAccumulator, ArrayLength) ->
    if
        RightIndex == ArrayLength ->
            CountAccumulator;
        true ->
            RightNum = array:get(RightIndex, Array),
            NewProduct = CurrentProduct * RightNum,

            {FinalProduct, FinalLeftIndex} =
                (fun AdjustLoop(Prod, LIdx) ->
                    if
                        Prod >= K andalso LIdx =< RightIndex ->
                            LeftNum = array:get(LIdx, Array),
                            AdjustLoop(Prod div LeftNum, LIdx + 1);
                        true ->
                            {Prod, LIdx}
                    end
                end)(NewProduct, LeftIndex),

            NewCount = CountAccumulator + (RightIndex - FinalLeftIndex + 1),

            solve(Array, K, RightIndex + 1, FinalLeftIndex, FinalProduct, NewCount, ArrayLength)
    end.