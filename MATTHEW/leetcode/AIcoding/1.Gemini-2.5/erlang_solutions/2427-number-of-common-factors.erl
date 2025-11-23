-spec commonFactors(A :: integer(), B :: integer()) -> integer().
commonFactors(A, B) ->
    MinVal = min(A, B),
    count_common_factors(1, MinVal, A, B, 0).

count_common_factors(Current, Max, A, B, Acc) when Current =< Max ->
    IsFactorA = (A rem Current == 0),
    IsFactorB = (B rem Current == 0),
    case {IsFactorA, IsFactorB} of
        {true, true} ->
            count_common_factors(Current + 1, Max, A, B, Acc + 1);
        _ ->
            count_common_factors(Current + 1, Max, A, B, Acc)
    end;
count_common_factors(_Current, _Max, _A, _B, Acc) ->
    Acc.