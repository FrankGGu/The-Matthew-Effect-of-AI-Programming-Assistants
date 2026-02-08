-module(longest_subarray).
-export([longestSubarray/1]).

longestSubarray(Nums) ->
    longestSubarray(Nums, 0, 0, 0, 0).

longestSubarray([], _Left, _Right, _ZeroCount, MaxLen) ->
    MaxLen;
longestSubarray([H | T], Left, Right, ZeroCount, MaxLen) ->
    case H of
        0 ->
            NewZeroCount = ZeroCount + 1,
            if
                NewZeroCount > 1 ->
                    NewLeft = Left + 1,
                    NewRight = Right + 1,
                    NewMaxLen = max(MaxLen, Right - Left),
                    longestSubarray(T, NewLeft, NewRight, NewZeroCount, NewMaxLen);
                true ->
                    NewRight = Right + 1,
                    NewMaxLen = max(MaxLen, Right - Left),
                    longestSubarray(T, Left, NewRight, NewZeroCount, NewMaxLen)
            end;
        _ ->
            NewRight = Right + 1,
            NewMaxLen = max(MaxLen, Right - Left),
            longestSubarray(T, Left, NewRight, ZeroCount, NewMaxLen)
    end.