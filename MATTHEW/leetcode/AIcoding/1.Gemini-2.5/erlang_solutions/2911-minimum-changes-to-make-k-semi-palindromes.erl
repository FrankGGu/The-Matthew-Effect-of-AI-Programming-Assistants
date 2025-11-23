-module(solution).
-export([min_changes_to_make_k_semi_palindromes/2]).

calculate_cost_for_substring(STuple, StartIdx, EndIdx) ->
    SubLen = EndIdx - StartIdx + 1,
    if SubLen < 2 ->
        0; % Substrings of length 0 or 1 are always semi-palindromes with 0 changes.
    true ->
        HalfLen = SubLen div 2,
        calculate_cost_loop(STuple, StartIdx, SubLen, HalfLen, 0, 0)
    end.

calculate_cost_loop(_STuple, _StartIdx, _SubLen, HalfLen, K, Changes) when K >= HalfLen ->
    Changes;
calculate_cost_loop(STuple, StartIdx, SubLen, HalfLen, K, Changes) ->
    %% Erlang tuples are 1-indexed, so add 1 to 0-indexed positions.
    CharLeft = element(StartIdx + K + 1, STuple),
    CharRightSymmetric = element(StartIdx + SubLen - 1 - K + 1, STuple),
    CharRightLeftOfSymmetric = element(StartIdx + SubLen - 2 - K + 1, STuple),

    NewChanges = 
        if CharLeft =/= CharRightSymmetric andalso CharLeft =/= CharRightLeftOfSymmetric ->
            Changes + 1;
        true ->
            Changes
        end,
    calculate_cost_loop(STuple, StartIdx, SubLen, HalfLen, K + 1, NewChanges).

min_changes_to_make_k_semi_palindromes(S, K) ->
    N = length(S),
    STuple = list_to_tuple(S),
    Infinity = N * N + 1, %% A value larger than any possible sum of changes (max N/2 changes per string, max N strings)

    %% Precompute Cost table: CostArray[i][j] stores changes for s[i..j]
    %% CostArray is an array of arrays (rows), where each row is an array of costs.
    CostArray = array:new([{fixed, true}, {size, N}]),
    CostArrayFilled = build_cost_array_rows(0, N, STuple, CostArray).

build_cost_array_rows(I, N, STuple, CostArray) when I >= N ->
    CostArray;
build_cost_array_rows(I, N, STuple, CostArray) ->
    Row = array:new([{fixed, true}, {size, N}]),
    RowFilled = build_cost_array_cols(I, I, N, STuple, Row),
    NewCostArray = array:set(I, RowFilled, CostArray),
    build_cost_array_rows(I + 1, N, STuple, NewCostArray).

build_cost_array_cols(I, J, N, STuple, Row) when J >= N ->
    Row;
build_cost_array_cols(I, J, N, STuple, Row) ->
    Val = calculate_cost_for_substring(STuple, I, J),
    NewRow = array:set(J, Val, Row),
    build_cost_array_cols(I, J + 1, N, STuple, NewRow).

    %% Initialize DP table: DP[i][j] stores min changes for s[0..i-1] using j semi-palindromes.
    %% DP is an array of arrays.
    DP = array:new([{fixed, true}, {size, N + 1}]),
    DPInitialized = init_dp_rows(0, N, K, Infinity, DP).

init_dp_rows(I, N, K, Infinity, DP) when I > N ->
    DP;
init_dp_rows(I, N, K, Infinity, DP) ->
    Row = array:new([{fixed, true}, {size, K + 1}]),
    RowInitialized = init_dp_cols(I, 0, K, Infinity, Row),
    NewDP = array:set(I, RowInitialized, DP),
    init_dp_rows(I + 1, N, K, Infinity, NewDP).

init_dp_cols(I, J, K, Infinity, Row) when J > K ->
    Row;
init_dp_cols(I, J, K, Infinity, Row) ->
    Val = if I == 0 andalso J == 0 -> 0; true -> Infinity end,
    NewRow = array:set(J, Val, Row),
    init_dp_cols(I, J + 1, K, Infinity, NewRow).

    %% Fill DP table using dynamic programming.
    DPFilled = fill_dp_k_loop(1, K, N, Infinity, CostArrayFilled, DPInitialized).

fill_dp_k_loop(J, K, N, Infinity, CostArray, DP) when J > K ->
    DP;
fill_dp_k_loop(J, K, N, Infinity, CostArray, DP) ->
    NewDP = fill_dp_i_loop(J, 1, N, Infinity, CostArray, DP),
    fill_dp_k_loop(J + 1, K, N, Infinity, CostArray, NewDP).

fill_dp_i_loop(J, I, N, Infinity, CostArray, DP) when I > N ->
    DP;
fill_dp_i_loop(J, I, N, Infinity, CostArray, DP) ->
    CurrentMin = Infinity,
    CurrentMinCalculated = fill_dp_p_loop(J, I, 0, Infinity, CostArray, DP, CurrentMin),

    DP_I_Row = array:get(I, DP),
    DP_I_Row_Updated = array:set(J, CurrentMinCalculated, DP_I_Row),
    NewDP = array:set(I, DP_I_Row_Updated, DP),
    fill_dp_i_loop(J, I + 1, N, Infinity, CostArray, NewDP).

fill_dp_p_loop(J, I, P, Infinity, CostArray, DP, CurrentMin) when P >= I ->
    CurrentMin;
fill_dp_p_loop(J, I, P, Infinity, CostArray, DP, CurrentMin) ->
    PrevDPVal = array:get(J - 1, array:get(P, DP)),
    NewCurrentMin = 
        if PrevDPVal =/= Infinity ->
            CostVal = array:get(I - 1, array:get(P, CostArray)),
            min(CurrentMin, PrevDPVal + CostVal);
        true ->
            CurrentMin
        end,
    fill_dp_p_loop(J, I, P + 1, Infinity, CostArray, DP, NewCurrentMin).

    %% The result is DP[N][K].
    array:get(K, array:get(N, DPFilled)).