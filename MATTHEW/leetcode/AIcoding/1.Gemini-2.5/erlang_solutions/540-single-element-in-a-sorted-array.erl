-module(solution).
-export([singleNonDuplicate/1]).

singleNonDuplicate(Nums) ->
    Tuple = list_to_tuple(Nums),
    N = tuple_size(Tuple),
    binary_search(Tuple, 0, N - 1).

binary_search(Tuple, Low, High) ->
    if
        Low == High ->
            element(Low + 1, Tuple);
        true ->
            Mid = Low + (High - Low) div 2,
            AdjustedMid = Mid - (Mid band 1),

            Val1 = element(AdjustedMid + 1, Tuple),
            Val2 = element(AdjustedMid + 2, Tuple),

            if
                Val1 == Val2 ->
                    binary_search(Tuple, AdjustedMid + 2, High);
                true ->
                    binary_search(Tuple, Low, AdjustedMid)
            end
    end.