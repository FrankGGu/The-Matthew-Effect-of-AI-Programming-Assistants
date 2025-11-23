-module(solution).
-export([minimumCost/5]).

-define(INF, 1_000_000_000_000_000). % Sufficiently large number for costs up to 10^14

minimumCost(Source, Target, Original, Changed, Cost) ->
    % 1. Initialize cost matrix (26x26)
    % Each element is an array:new(26, {default, ?INF})
    InitialMatrix = [array:new(26, {default, ?INF}) || _ <- lists:seq(1, 26)],

    % Set cost[i][i] = 0
    Matrix0 = lists:foldl(fun(I, AccMatrix) ->
                              Row = array:get(I, AccMatrix),
                              UpdatedRow = array:set(I, 0, Row),
                              array:set(I, UpdatedRow, AccMatrix)
                          end, InitialMatrix, lists:seq(0, 25)),

    % 2. Populate initial costs from Original, Changed, Cost
    Matrix1 = lists:foldl(fun({OChar, CChar, Cst}, AccMatrix) ->
                              FromIdx = OChar - $a,
                              ToIdx = CChar - $a,

                              CurrentRow = array:get(FromIdx, AccMatrix),
                              CurrentCost = array:get(ToIdx, CurrentRow),

                              NewCost = min(CurrentCost, Cst),

                              UpdatedRow = array:set(ToIdx, NewCost, CurrentRow),
                              array:set(FromIdx, UpdatedRow, AccMatrix)
                          end, lists:zip3(Original, Changed, Cost), Matrix0),

    % 3. Apply Floyd-Warshall
    MatrixFW = lists:foldl(fun(K, AccMatrixK) ->
                               lists:foldl(fun(I, AccMatrixI) ->
                                               RowI = array:get(I, AccMatrixI),
                                               CostIK = array:get(K, RowI),
                                               if CostIK == ?INF ->
                                                      AccMatrixI;
                                                  true ->
                                                      UpdatedRowI = lists:foldl(fun(J, AccRowJ) ->
                                                                                    CostIJ = array:get(J, AccRowJ),
                                                                                    RowK = array:get(K, AccMatrixI),
                                                                                    CostKJ = array:get(J, RowK),
                                                                                    if CostKJ == ?INF ->
                                                                                           AccRowJ;
                                                                                       true ->
                                                                                           NewCostIJ = min(CostIJ, CostIK + CostKJ),
                                                                                           array:set(J, NewCostIJ, AccRowJ)
                                                                                    end
                                                                                end, RowI, lists:seq(0, 25)),
                                                      array:set(I, UpdatedRowI, AccMatrixI)
                                               end
                                           end, AccMatrixK, lists:seq(0, 25))
                           end, Matrix1, lists:seq(0, 25)),

    % 4. Calculate total conversion cost
    calculate_total_cost(Source, Target, MatrixFW, 0).

calculate_total_cost([], [], _Matrix, AccCost) ->
    AccCost;
calculate_total_cost([SHead|STail], [THead|TTail], Matrix, AccCost) ->
    FromIdx = SHead - $a,
    ToIdx = THead - $a,

    RowFrom = array:get(FromIdx, Matrix),
    CharCost = array:get(ToIdx, RowFrom),

    if CharCost == ?INF ->
        -1;
    true ->
        calculate_total_cost(STail, TTail, Matrix, AccCost + CharCost)
    end.