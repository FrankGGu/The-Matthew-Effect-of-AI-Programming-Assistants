-module(four_sum).
-export([four_sum/2]).

four_sum(Nums, Target) ->
    NumsSorted = lists:sort(Nums),
    N = length(Nums),
    Result = sets:new(),
    four_sum_helper(NumsSorted, Target, 0, N - 1, Result, []).

four_sum_helper(Nums, Target, L, R, Result, Acc) when L >= R ->
    Result;
four_sum_helper(Nums, Target, L, R, Result, Acc) ->
    N = length(Nums),
    case length(Acc) of
        0 ->
            lists:foreach(fun(I) ->
                                four_sum_helper(Nums, Target, I + 1, N - 1, Result, [lists:nth(I + 1, Nums)])
                        end, lists:seq(L, R - 3));
        1 ->
            I1 = hd(Acc),
            lists:foreach(fun(I) ->
                                four_sum_helper(Nums, Target, I + 1, N - 1, Result, [I1, lists:nth(I + 1, Nums)])
                        end, lists:seq(L, R - 2));
        2 ->
            [I1, I2] = Acc,
            lists:foreach(fun(I) ->
                                four_sum_helper(Nums, Target, I + 1, R, Result, [I1, I2, lists:nth(I + 1, Nums)])
                        end, lists:seq(L, R - 1));
        3 ->
            [I1, I2, I3] = Acc,
            lists:foreach(fun(I) ->
                                I4 = lists:nth(I + 1, Nums),
                                Sum = I1 + I2 + I3 + I4,
                                case Sum =:= Target of
                                    true ->
                                        sets:add_element(lists:sort([I1, I2, I3, I4]), Result);
                                    false ->
                                        ok
                                end
                        end, lists:seq(L, R))
    end,
    sets:to_list(Result).