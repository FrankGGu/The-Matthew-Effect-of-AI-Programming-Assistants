-module(solution).
-export([destroyTargets/2]).

destroyTargets(Nums, Space) ->
    % Step 1: Populate a map where keys are remainders (Num rem Space)
    % and values are maps containing the count of numbers with that remainder
    % and the minimum number itself for that remainder.
    RemainderStatsMap = lists:foldl(
        fun(Num, AccMap) ->
            Remainder = Num rem Space,
            case maps:find(Remainder, AccMap) of
                {ok, #{count := OldCount, min_val := OldMinVal}} ->
                    maps:put(Remainder, #{count => OldCount + 1, min_val => min(OldMinVal, Num)}, AccMap);
                error ->
                    maps:put(Remainder, #{count => 1, min_val => Num}, AccMap)
            end
        end,
        maps:new(),
        Nums
    ),

    % Step 2: Find the maximum count of targets that can be destroyed.
    MaxCount = maps:fold(
        fun(_Remainder, #{count := Count, min_val := _MinVal}, CurrentMaxCount) ->
            max(Count, CurrentMaxCount)
        end,
        0, % Initial maximum count
        RemainderStatsMap
    ),

    % Step 3: Find the minimum target value among all targets that correspond
    % to the MaxCount.
    % We can use the first element of Nums as an initial minimum,
    % as Nums is guaranteed to be non-empty and its elements are non-negative.
    MinTarget = maps:fold(
        fun(_Remainder, #{count := Count, min_val := MinVal}, CurrentMinTarget) ->
            if
                Count == MaxCount ->
                    min(MinVal, CurrentMinTarget);
                true ->
                    CurrentMinTarget
            end
        end,
        hd(Nums), % Initial minimum target value
        RemainderStatsMap
    ),
    MinTarget.