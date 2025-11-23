-module(solution).
-export([maximumTripletValue/1]).

maximumTripletValue(Nums) ->
    N = length(Nums),
    Max = lists:seq(0, N-1),
    MaxValues = lists:foldl(fun(I, Acc) ->
        case Acc of
            {MaxA, MaxB} ->
                A = lists:nth(I+1, Nums),
                B = lists:foldl(fun(J, Acc2) ->
                    case Acc2 of
                        {MaxBVal, _} when J > I ->
                            BVal = lists:nth(J+1, Nums),
                            if BVal > MaxBVal -> {BVal, J}; true -> Acc2 end;
                        _ -> Acc2
                    end
                end, {0, -1}, Max),
                if A > MaxA -> {A, B}; true -> Acc end;
            _ -> Acc
        end
    end, {0, {0, -1}}, Max),
    {MaxA, {MaxB, _}} = MaxValues,
    MaxA - MaxB.