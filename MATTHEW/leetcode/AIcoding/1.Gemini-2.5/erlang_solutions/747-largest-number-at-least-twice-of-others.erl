-module(solution).
-export([dominant_index/1]).

dominant_index(Nums) ->
    case find_max_and_index(Nums, -1, -1, 0) of
        {-1, -1} -> % Handles empty list or list with only negative numbers (if allowed)
            -1;
        {MaxVal, MaxIdx} ->
            check_condition(Nums, 0, MaxVal, MaxIdx)
    end.

find_max_and_index([], MaxVal, MaxIdx, _) ->
    {MaxVal, MaxIdx};
find_max_and_index([H|T], CurrentMaxVal, CurrentMaxIdx, CurrentListIdx) when H > CurrentMaxVal ->
    find_max_and_index(T, H, CurrentListIdx, CurrentListIdx + 1);
find_max_and_index([_|T], CurrentMaxVal, CurrentMaxIdx, CurrentListIdx) ->
    find_max_and_index(T, CurrentMaxVal, CurrentMaxIdx, CurrentListIdx + 1).

check_condition([], _, _, MaxIdx) ->
    MaxIdx;
check_condition([H|T], CurrentListIdx, MaxVal, MaxIdx) ->
    if CurrentListIdx == MaxIdx ->
        check_condition(T, CurrentListIdx + 1, MaxVal, MaxIdx);
    true ->
        if MaxVal >= 2 * H ->
            check_condition(T, CurrentListIdx + 1, MaxVal, MaxIdx);
        true ->
            -1
        end
    end.