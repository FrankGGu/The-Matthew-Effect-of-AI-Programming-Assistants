-module(solution).
-export([checkArray/2]).

checkArray(Nums, K) ->
    N = length(Nums),
    DiffArray = array:new([{size, N}, {fixed, true}, {default, 0}]),
    check_array_helper(0, N, K, Nums, DiffArray, 0).

check_array_helper(I, N, K, Nums, DiffArray, CurrentDecrement) ->
    if
        I == N ->
            true;
        true ->
            NewCurrentDecrement = 
                if
                    I - K >= 0 ->
                        CurrentDecrement - array:get(I - K, DiffArray);
                    true ->
                        CurrentDecrement
                end,

            NumI = lists:nth(I + 1, Nums),
            EffectiveNumI = NumI - NewCurrentDecrement,

            if
                EffectiveNumI < 0 ->
                    false;
                EffectiveNumI > 0 ->
                    if
                        I + K > N ->
                            false;
                        true ->
                            UpdatedDiffArray = array:set(I, EffectiveNumI, DiffArray),
                            UpdatedCurrentDecrement = NewCurrentDecrement + EffectiveNumI,
                            check_array_helper(I + 1, N, K, Nums, UpdatedDiffArray, UpdatedCurrentDecrement)
                    end;
                true ->
                    check_array_helper(I + 1, N, K, Nums, DiffArray, NewCurrentDecrement)
            end
    end.