-module(solution).
-export([sellingPiecesOfWood/3]).

sellingPiecesOfWood(M, N, PricesList) ->
    PriceMap = lists:foldl(
        fun([H, W, P], Acc) -> Acc#{ {H, W} => P } end,
        #{},
        PricesList
    ),

    % Initialize a 2D array (M+1 x N+1) with zeros.
    % This array will store the maximum price for a piece of size (i, j).
    DP = array:new({M + 1, N + 1}, 0),

    % Iterate through all possible piece sizes from 1x1 up to MxN
    FinalDP = lists:foldl(
        fun(I, CurrentDP_I_Loop) ->
            lists:foldl(
                fun(J, CurrentDP_J_Loop) ->
                    % Get the current maximum price for a piece of size IxJ (initially 0 from DP table)
                    CurrentMaxPrice = array:get(I, J, CurrentDP_J_Loop),

                    % 1. Check if a direct price exists for this piece size in the PriceMap
                    PriceForIJ = maps:get({I, J}, PriceMap, 0),
                    MaxP = max(CurrentMaxPrice, PriceForIJ),

                    % 2. Consider horizontal cuts: Cut piece (I, J) into (K, J) and (I-K, J)
                    MaxP_after_h_cuts = lists:foldl(
                        fun(K, AccMaxP) ->
                            Val1 = array:get(K, J, CurrentDP_J_Loop),
                            Val2 = array:get(I - K, J, CurrentDP_J_Loop),
                            max(AccMaxP, Val1 + Val2)
                        end,
                        MaxP,
                        lists:seq(1, I - 1)
                    ),

                    % 3. Consider vertical cuts: Cut piece (I, J) into (I, K) and (I, J-K)
                    MaxP_after_v_cuts = lists:foldl(
                        fun(K, AccMaxP) ->
                            Val1 = array:get(I, K, CurrentDP_J_Loop),
                            Val2 = array:get(I, J - K, CurrentDP_J_Loop),
                            max(AccMaxP, Val1 + Val2)
                        end,
                        MaxP_after_h_cuts, % Start from the max price after horizontal cuts
                        lists:seq(1, J - 1)
                    ),

                    % Update the DP table with the maximum price for piece IxJ
                    array:set(I, J, MaxP_after_v_cuts, CurrentDP_J_Loop)
                end,
                CurrentDP_I_Loop,
                lists:seq(1, N)
            )
        end,
        DP,
        lists:seq(1, M)
    ),

    % The final answer is the maximum price for the M x N piece
    array:get(M, N, FinalDP).