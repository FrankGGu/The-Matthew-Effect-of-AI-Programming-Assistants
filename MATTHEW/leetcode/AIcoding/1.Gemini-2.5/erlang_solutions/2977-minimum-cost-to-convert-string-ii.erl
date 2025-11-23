-module(solution).
-export([minimum_cost/8]).

-define(INF, 1000000000000000000). % A very large number

minimum_cost(SourceList, TargetList, OriginalList, ChangedList, Cost, OriginalSubList, ChangedSubList, CostSub) ->
    % Convert all string lists to binaries for efficient substring operations
    Source = list_to_binary(SourceList),
    Target = list_to_binary(TargetList),
    OriginalBin = [list_to_binary(S) || S <- OriginalList],
    ChangedBin = [list_to_binary(S) || S <- ChangedList],
    OriginalSubBin = [list_to_binary(S) || S <- OriginalSubList],
    ChangedSubBin = [list_to_binary(S) || S <- ChangedSubList],

    N = byte_size(Source), % Length of binary string

    % 1. Precompute character conversion costs using Floyd-Warshall
    CharMinCost0 = array:new([{fixed, true}, {size, 26}]),
    CharMinCost1 = initialize_char_costs(0, 25, CharMinCost0),
    CharMinCost2 = add_direct_char_costs(OriginalBin, ChangedBin, Cost, CharMinCost1),
    CharMinMinCost = floyd_warshall(CharMinCost2),

    % 2. Precompute substring conversion costs
    SubCostMap = build_sub_cost_map(OriginalSubBin, ChangedSubBin, CostSub, #{}),

    % 3. Dynamic Programming
    DP0 = array:new([{fixed, true}, {size, N + 1}, {default, ?INF}]),
    DP = array:set(N, 0, DP0),

    % Iterate i from N-1 down to 0
    ResultDP = calculate_dp(N - 1, Source, Target, CharMinMinCost, SubCostMap, DP),

    CostResult = array:get(0, ResultDP),
    case CostResult of
        ?INF -> -1; % If dp[0] is INF, it's impossible
        _ -> CostResult
    end.

initialize_char_costs(Idx, MaxIdx, AccArray) when Idx =< MaxIdx ->
    AccArray2 = array:set(Idx, array:new([{fixed, true}, {size, 26}, {default, ?INF}]), AccArray),
    AccArray3 = array:set(Idx, array:set(Idx, 0, array:get(Idx, AccArray2)), AccArray2),
    initialize_char_costs(Idx + 1, MaxIdx, AccArray3);
initialize_char_costs(_Idx, _MaxIdx, AccArray) ->
    AccArray.

add_direct_char_costs([], [], [], AccArray) -> AccArray;
add_direct_char_costs([O_bin | Os], [C_bin | Cs], [CostVal | Costs], AccArray) ->
    U = binary:at(O_bin, 0) - $a, % Get char value from binary, 0-indexed
    V = binary:at(C_bin, 0) - $a,
    CurrentRow = array:get(U, AccArray),
    CurrentCost = array:get(V, CurrentRow),
    NewCost = min(CurrentCost, CostVal),
    NewRow = array:set(V, NewCost, CurrentRow),
    NewAccArray = array:set(U, NewRow, AccArray),
    add_direct_char_costs(Os, Cs, Costs, NewAccArray).

floyd_warshall(CharMinCost) ->
    FWCost = CharMinCost,
    floyd_warshall_k(0, 25, FWCost).

floyd_warshall_k(K, MaxK, AccArray) when K =< MaxK ->
    AccArrayK = floyd_warshall_i(0, 25, K, AccArray),
    floyd_warshall_k(K + 1, MaxK, AccArrayK);
floyd_warshall_k(_K, _MaxK, AccArray) ->
    AccArray.

floyd_warshall_i(I, MaxI, K, AccArray) when I =< MaxI ->
    AccArrayI = floyd_warshall_j(0, 25, I, K, AccArray),
    floyd_warshall_i(I + 1, MaxI, K, AccArrayI);
floyd_warshall_i(_I, _MaxI, _K, AccArray) ->
    AccArray.

floyd_warshall_j(J, MaxJ, I, K, AccArray) when J =< MaxJ ->
    CostIK = array:get(K, array:get(I, AccArray)),
    CostKJ = array:get(J, array:get(K, AccArray)),

    NewCost =
        if
            CostIK == ?INF orelse CostKJ == ?INF -> ?INF;
            true -> CostIK + CostKJ
        end,

    CurrentCostIJ = array:get(J, array:get(I, AccArray)),
    UpdatedCost = min(CurrentCostIJ, NewCost),

    CurrentRowI = array:get(I, AccArray),
    NewRowI = array:set(J, UpdatedCost, CurrentRowI),
    NewAccArray = array:set(I, NewRowI, AccArray),
    floyd_warshall_j(J + 1, MaxJ, I, K, NewAccArray);
floyd_warshall_j(_J, _MaxJ, _I, _K, AccArray) ->
    AccArray.

build_sub_cost_map([], [], [], AccMap) -> AccMap;
build_sub_cost_map([OS_bin | OSs], [CS_bin | CSs], [CostVal | Costs], AccMap) ->
    Key = {OS_bin, CS_bin},
    CurrentCost = maps:get(Key, AccMap, ?INF),
    NewMap = maps:put(Key, min(CurrentCost, CostVal), AccMap),
    build_sub_cost_map(OSs, CSs, Costs, NewMap).

calculate_dp(I, Source, Target, CharMinMinCost, SubCostMap, DP) when I >= 0 ->
    N = byte_size(Source),
    CurrentMinCost = ?INF,

    % Case 1: Match character
    CharS = binary:at(Source, I),
    CharT = binary:at(Target, I),
    Cost1 =
        if
            CharS == CharT ->
                array:get(I + 1, DP);
            true ->
                ?INF
        end,
    MinCostSoFar1 = min(CurrentMinCost, Cost1),

    % Case 2: Convert character
    CharSIdx = CharS - $a,
    CharTIdx = CharT - $a,
    CharConvCost = array:get(CharTIdx, array:get(CharSIdx, CharMinMinCost)),
    Cost2 =
        if
            CharConvCost == ?INF -> ?INF;
            true -> CharConvCost + array:get(I + 1, DP)
        end,
    MinCostSoFar2 = min(MinCostSoFar1, Cost2),

    % Case 3: Substring conversion
    MinCostSoFar3 = calculate_dp_substring_conversions(I, N, Source, Target, SubCostMap, DP, MinCostSoFar2),

    UpdatedDP = array:set(I, MinCostSoFar3, DP),
    calculate_dp(I - 1, Source, Target, CharMinMinCost, SubCostMap, UpdatedDP);
calculate_dp(_I, _Source, _Target, _CharMinMinCost, _SubCostMap, DP) ->
    DP.

calculate_dp_substring_conversions(I, N, Source, Target, SubCostMap, DP, AccMinCost) ->
    maps:fold(fun(Key, SubCost, CurrentFoldMinCost) ->
        {OrigSub, ChangedSub} = Key,
        L = byte_size(OrigSub),

        if
            I + L =< N ->
                SrcSubPart = binary:part(Source, I, L), % binary:part(Binary, Pos, Len)
                TgtSubPart = binary:part(Target, I, L),
                if
                    SrcSubPart == OrigSub andalso TgtSubPart == ChangedSub ->
                        NextDPVal = array:get(I + L, DP),
                        if
                            NextDPVal == ?INF -> CurrentFoldMinCost;
                            true -> min(CurrentFoldMinCost, SubCost + NextDPVal)
                        end;
                    true -> CurrentFoldMinCost
                end;
            true -> CurrentFoldMinCost
        end
    end, AccMinCost, SubCostMap).