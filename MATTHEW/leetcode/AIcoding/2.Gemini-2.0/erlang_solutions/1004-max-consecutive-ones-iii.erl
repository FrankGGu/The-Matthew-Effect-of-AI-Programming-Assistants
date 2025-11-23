-module(max_consecutive_ones_iii).
-export([longestOnes/2]).

longestOnes(Nums, K) ->
    longestOnes(Nums, K, 0, 0, 0).

longestOnes([], _, MaxLen, _, _) ->
    MaxLen;
longestOnes(Nums, K, Left, Right, ZeroCount) ->
    case Nums of
        [Num | Rest] ->
            NewZeroCount = case Num of
                0 -> ZeroCount + 1;
                _ -> ZeroCount
            end,
            case NewZeroCount =< K of
                true ->
                    longestOnes(Rest, K, Left, Right + 1, NewZeroCount);
                false ->
                    case lists:nth(Left + 1, Nums) of
                        0 ->
                            longestOnes(Rest, K, Left + 1, Right + 1, NewZeroCount - 1);
                        _ ->
                            longestOnes(Rest, K, Left + 1, Right + 1, NewZeroCount)
                    end
            end;
        [] ->
            Right - Left
    end.