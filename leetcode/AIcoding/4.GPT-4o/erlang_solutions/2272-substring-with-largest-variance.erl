-module(solution).
-export([largest_variance/1]).

largest_variance(S) ->
    CharList = string:to_list(S),
    UniqueChars = lists:usort(CharList),
    largest_variance_helper(CharList, UniqueChars).

largest_variance_helper(CharList, UniqueChars) ->
    lists:foldl(fun(C1, Acc) ->
        lists:foldl(fun(C2, A) when C1 /= C2 -> 
            max(A, calc_variance(CharList, C1, C2));
        end, A, UniqueChars);
    end, 0, UniqueChars).

calc_variance(CharList, C1, C2) ->
    {Count1, Count2, Variance, MaxVariance} = lists:foldl(fun(Char, {C1Count, C2Count, Variance, MaxVariance}) ->
        case Char of
            C1 -> {C1Count + 1, C2Count, Variance + 1, max(MaxVariance, Variance + 1)};
            C2 -> 
                if C1Count > 0 -> 
                    {C1Count, C2Count + 1, Variance - 1, MaxVariance};
                true -> 
                    {C1Count, C2Count + 1, Variance, MaxVariance}
                end;
            _ -> {C1Count, C2Count, Variance, MaxVariance}
        end
    end, {0, 0, 0, 0}, CharList),

    case Count1 > 0 andalso Count2 > 0 of
        true -> MaxVariance;
        false -> 0
    end.