-module(solution).
-export([maximumANDSum/2]).

maximumANDSum(Nums, NumSlots) ->
    % Nums is an Erlang array.
    LenNums = array:size(Nums),
    % Create an ETS table for memoization.
    % The key will be {CurrentIndex, SlotMask}.
    Memo = ets:new(memo_table, [set, public, {read_concurrency, true}]),
    solve(Nums, LenNums, NumSlots, 0, 0, Memo).

solve(_NumsArray, LenNums, _NumSlots, CurrentIndex, _SlotMask, _Memo) when CurrentIndex == LenNums ->
    0;
solve(NumsArray, LenNums, NumSlots, CurrentIndex, SlotMask, Memo) ->
    Key = {CurrentIndex, SlotMask},
    % Check if the result for this subproblem is already memoized.
    case ets:lookup(Memo, Key) of
        [{_, _, Value}] -> Value; % Return memoized value
        _ ->
            % Get the current number to be placed. array:get is O(1).
            CurrentNum = array:get(CurrentIndex, NumsArray),
            MaxScore = 0,
            % Iterate through each slot from 1 to NumSlots.
            Result = lists:foldl(fun(Slot, AccMax) ->
                % Determine the current state of the slot (0: empty, 1: one item, 2: two items).
                % Each slot uses 2 bits in the SlotMask. For slot S, bits are 2*(S-1) and 2*(S-1)+1.
                SlotState = (SlotMask bsr (2 * (Slot - 1))) band 3,
                case SlotState of
                    0 -> % Slot is empty, place CurrentNum as the first item.
                        % Update SlotMask: set slot S state to 1 (one item).
                        NewSlotMask = (SlotMask band (bnot (3 bsl (2 * (Slot - 1))))) bor (1 bsl (2 * (Slot - 1))),
                        % Calculate score for this placement and recurse.
                        Score = (CurrentNum band Slot) + solve(NumsArray, LenNums, NumSlots, CurrentIndex + 1, NewSlotMask, Memo),
                        max(AccMax, Score);
                    1 -> % Slot has one item, place CurrentNum as the second item.
                        % Update SlotMask: set slot S state to 2 (two items, full).
                        NewSlotMask = (SlotMask band (bnot (3 bsl (2 * (Slot - 1))))) bor (2 bsl (2 * (Slot - 1))),
                        % Calculate score for this placement and recurse.
                        Score = (CurrentNum band Slot) + solve(NumsArray, LenNums, NumSlots, CurrentIndex + 1, NewSlotMask, Memo),
                        max(AccMax, Score);
                    2 -> % Slot is full, CurrentNum cannot be placed here.
                        AccMax
                end
            end, MaxScore, lists:seq(1, NumSlots)),
            % Memoize the computed result before returning.
            ets:insert(Memo, {Key, Result}),
            Result
    end.