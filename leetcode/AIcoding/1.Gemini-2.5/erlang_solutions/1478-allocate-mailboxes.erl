-module(solution).
-export([minMailboxes/2]).

-include_lib("kernel/include/array.hrl"). % Required for array module

cost_for_range(HousesArr, StartIdx, EndIdx) ->
    MedianIdx = (StartIdx + EndIdx) div 2,
    MedianVal = array:get(MedianIdx, HousesArr),
    lists:foldl(fun(Idx, Acc) ->
                    HousePos = array:get(Idx, HousesArr),
                    Acc + abs(HousePos - MedianVal)
                end, 0, lists:seq(StartIdx, EndIdx)).

minMailboxes(Houses, K) ->
    % 1. Sort houses
    SortedHouses = lists:sort(Houses),
    N = length(SortedHouses),

    % Convert sorted houses list to an array for O(1) access
    HousesArr = array:from_list(SortedHouses),

    % 2. Precompute cost table
    % Cost[i][j] = cost of placing one mailbox for houses[i...j]
    % Cost is an array of arrays. Cost[i] is an array for row i.
    Cost = array:new([{fixed, true}, {size, N}]),
    Cost_filled = lists:foldl(fun(I, CurrentCostTable) ->
                                    Row = array:new([{fixed, true}, {size, N}]),
                                    Row_filled = lists:foldl(fun(J, CurrentRow) ->
                                                                if J >= I ->
                                                                    RangeCost = cost_for_range(HousesArr, I, J),
                                                                    array:set(J, RangeCost, CurrentRow);
                                                                true ->
                                                                    CurrentRow % For J < I, this part of the row is not used
                                                                end
                                                            end, Row, lists:seq(0, N-1)),
                                    array:set(I, Row_filled, CurrentCostTable)
                                end, Cost, lists:seq(0, N-1)),

    % 3. Initialize DP table
    % DP[i][j] = min cost to place j mailboxes for houses[0...i-1]
    % DP table size (N+1) x (K+1)
    % DP is an array of arrays. DP[i] is an array for row i.
    Infinity = 1_000_000_000, % A sufficiently large number

    DP = array:new([{fixed, true}, {size, N+1}]),
    DP_initialized = lists:foldl(fun(I, CurrentDPTable) ->
                                        Row = array:new([{fixed, true}, {size, K+1}]),
                                        Row_initialized = lists:foldl(fun(J, CurrentRow) ->
                                                                        Val = if I==0 -> 0; % No houses, no cost
                                                                                 J==0 -> Infinity; % Houses but no mailboxes, infinite cost
                                                                                 true -> Infinity % Default for other cells
                                                                              end,
                                                                        array:set(J, Val, CurrentRow)
                                                                    end, Row, lists:seq(0, K)),
                                        array:set(I, Row_initialized, CurrentDPTable)
                                    end, DP, lists:seq(0, N)),

    % 4. Fill DP table
    % I from 1 to N (number of houses considered, houses[0...I-1])
    % J from 1 to K (number of mailboxes)
    DP_filled = lists:foldl(fun(I, CurrentDPTable) ->
                                    DP_Row_I = array:get(I, CurrentDPTable),
                                    DP_Row_I_updated = lists:foldl(fun(J, CurrentRowI) ->
                                                                        MinCost = lists:foldl(fun(P, AccMinCost) ->
                                                                                                    % P is the split point.
                                                                                                    % Houses[0...P-1] covered by J-1 mailboxes.
                                                                                                    % Houses[P...I-1] covered by 1 mailbox.
                                                                                                    PrevDP = array:get(J-1, array:get(P, CurrentDPTable)),
                                                                                                    CurrentSegmentCost = array:get(I-1, array:get(P, Cost_filled)),
                                                                                                    min(AccMinCost, PrevDP + CurrentSegmentCost)
                                                                                                end, Infinity, lists:seq(0, I-1)), % P from 0 to I-1
                                                                        array:set(J, MinCost, CurrentRowI)
                                                                    end, DP_Row_I, lists:seq(1, K)),
                                    array:set(I, DP_Row_I_updated, CurrentDPTable)
                                end, DP_initialized, lists:seq(1, N)),

    % 5. Result is DP[N][K]
    array:get(K, array:get(N, DP_filled)).