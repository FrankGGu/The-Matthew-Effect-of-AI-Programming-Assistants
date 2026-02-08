-module(solution).
-export([countSubarraysWhereMaxElementAppearsAtLeastKTimes/2]).

countSubarraysWhereMaxElementAppearsAtLeastKTimes(Nums, K) ->
    N = length(Nums),
    if N == 0 -> 0;
       true ->
            MaxVal = lists:max(Nums),
            MaxIndices = get_max_indices(Nums, MaxVal),
            M = length(MaxIndices),
            if M < K -> 0;
               true ->
                   calculate_count(MaxIndices, K, N, M)
            end
    end.

get_max_indices(Nums, MaxVal) ->
    get_max_indices(Nums, MaxVal, 0, []).

get_max_indices([], _MaxVal, _Idx, Acc) ->
    lists:reverse(Acc);
get_max_indices([H|T], MaxVal, Idx, Acc) ->
    if H == MaxVal ->
        get_max_indices(T, MaxVal, Idx + 1, [Idx | Acc]);
    true ->
        get_max_indices(T, MaxVal, Idx + 1, Acc)
    end.

calculate_count(MaxIndices, K, N, M) ->
    calculate_count(MaxIndices, K, N, M, K - 1, 0).

calculate_count(_MaxIndices, _K, _N, M, J, Acc) when J >= M ->
    Acc;
calculate_count(MaxIndices, K, N, M, J, Acc) ->
    % P_j_minus_k_plus_1 is the (j-k+1)-th index (0-based) in MaxIndices
    % Its 1-based index for lists:nth is (j-k+1) + 1 = j-k+2
    P_j_minus_k_plus_1 = lists:nth(J - K + 2, MaxIndices),

    % P_j is the j-th index (0-based) in MaxIndices
    % Its 1-based index for lists:nth is j + 1
    P_j = lists:nth(J + 1, MaxIndices),

    PrevMaxIdx = if J - K >= 0 ->
                     % P_j_minus_k is the (j-k)-th index (0-based) in MaxIndices
                     % Its 1-based index for lists:nth is (j-k) + 1
                     lists:nth(J - K + 1, MaxIndices);
                 true ->
                     -1
                 end,

    LeftChoices = P_j_minus_k_plus_1 - PrevMaxIdx,
    RightChoices = N - P_j,

    NewAcc = Acc + LeftChoices * RightChoices,
    calculate_count(MaxIndices, K, N, M, J + 1, NewAcc).