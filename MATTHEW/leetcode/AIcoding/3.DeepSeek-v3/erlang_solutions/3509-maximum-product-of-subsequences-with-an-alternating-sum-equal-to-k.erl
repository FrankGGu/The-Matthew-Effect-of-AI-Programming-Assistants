-module(solution).
-export([maximum_product/2]).

maximum_product(Nums, K) ->
    N = length(Nums),
    MaxNeg = -1000000000,
    DP = lists:duplicate(N + 1, lists:duplicate(K + 1, {1, MaxNeg})),
    {Pos, Neg} = lists:foldl(fun(I, {DPAcc, _}) ->
        Num = lists:nth(I, Nums),
        NewDP = lists:foldl(fun(J, Row) ->
            {prev_pos, prev_neg} = lists:nth(J, Row),
            {case J >= Num andalso (J - Num) rem 2 == 0 of
                true -> 
                    case (J - Num) >= 0 of
                        true -> 
                            {P, N} = lists:nth((J - Num) + 1, lists:nth(I, DPAcc)),
                            max(prev_pos, P * Num);
                        false -> prev_pos
                    end;
                false -> prev_pos
            end,
            case J >= Num andalso (J - Num) rem 2 == 1 of
                true -> 
                    case (J - Num) >= 0 of
                        true -> 
                            {P, _} = lists:nth((J - Num) + 1, lists:nth(I, DPAcc)),
                            max(prev_neg, P * Num);
                        false -> prev_neg
                    end;
                false -> prev_neg
            end}
        end, [], lists:seq(1, K + 1)),
        {lists:sublist(DPAcc, I - 1) ++ [NewDP] ++ lists:nthtail(I, DPAcc), NewDP}
    end, {DP, []}, lists:seq(1, N)),
    {ResPos, ResNeg} = lists:nth(K + 1, lists:last(DP)),
    case max(ResPos, ResNeg) of
        Max when Max > 0 -> Max;
        _ -> -1
    end.