-module(solution).
-export([singleNonDuplicate/1]).

singleNonDuplicate(Nums) ->
    Len = length(Nums),
    NumsTuple = list_to_tuple(Nums),
    binary_search(NumsTuple, 0, Len - 1).

binary_search(Nums, Low, High) ->
    if
        Low == High ->
            element(Low + 1, Nums);
        true ->
            Mid = Low + (High - Low) div 2,
            MidVal = element(Mid + 1, Nums),
            if
                Mid rem 2 == 0 ->
                    NextVal = element(Mid + 1 + 1, Nums),
                    if
                        MidVal == NextVal ->
                            binary_search(Nums, Mid + 2, High);
                        true ->
                            binary_search(Nums, Low, Mid)
                    end;
                true ->
                    PrevVal = element(Mid - 1 + 1, Nums),
                    if
                        MidVal == PrevVal ->
                            binary_search(Nums, Mid + 1, High);
                        true ->
                            binary_search(Nums, Low, Mid)
                    end
            end
    end.