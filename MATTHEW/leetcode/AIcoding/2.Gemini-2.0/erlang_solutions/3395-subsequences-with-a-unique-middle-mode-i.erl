-module(unique_middle_mode_i).
-export([subsequences_with_unique_middle_mode/1]).

subsequences_with_unique_middle_mode(Nums) ->
    N = length(Nums),
    subsequences_with_unique_middle_mode(Nums, N, []).

subsequences_with_unique_middle_mode(_Nums, _N, []) -> 0;

subsequences_with_unique_middle_mode(Nums, N, [_ | T]) ->
    subsequences_with_unique_middle_mode(Nums, N, T).

subsequences_with_unique_middle_mode(Nums, N, Acc) ->
    lists:foldl(
        fun(I, Count) ->
            subsequences_with_unique_middle_mode_helper(Nums, I, [], Count)
        end,
        0,
        lists:seq(1, N)
    ).

subsequences_with_unique_middle_mode_helper(_Nums, _Index, Subsequence, Count) ->
    case length(Subsequence) of
        0 -> Count;
        Len when Len rem 2 /= 1 -> Count;
        Len ->
            case has_unique_middle_mode(Subsequence) of
                true -> Count + 1;
                false -> Count
            end
    end.

subsequences_with_unique_middle_mode_helper(Nums, Index, Subsequence, Count) ->
    N = length(Nums),
    if Index > N then
        subsequences_with_unique_middle_mode_helper(Nums, Index - N, Subsequence, Count)
    else
        NewSubsequence = Subsequence ++ [lists:nth(Index, Nums)],
        NewCount1 = subsequences_with_unique_middle_mode_helper(Nums, Index + 1, NewSubsequence, Count),
        NewCount2 = subsequences_with_unique_middle_mode_helper(Nums, Index + 1, Subsequence, Count),
        NewCount1
    end.

has_unique_middle_mode(List) ->
    Len = length(List),
    MiddleIndex = Len div 2 + 1,
    MiddleValue = lists:nth(MiddleIndex, List),
    ModeCount = lists:foldl(
        fun(X, Count) ->
            if X == MiddleValue then
                Count + 1
            else
                Count
            end
        end,
        0,
        List
    ),
    lists:all(
        fun(X) ->
            Count = lists:foldl(
                fun(Y, C) ->
                    if Y == X then
                        C + 1
                    else
                        C
                    end
                end,
                0,
                List
            ),
            X == MiddleValue or Count < ModeCount
        end,
        lists:usort(List)
    ).