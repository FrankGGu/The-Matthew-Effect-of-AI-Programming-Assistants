-module(solution).
-export([find_good_indices/2]).

find_good_indices(Nums, k) ->
    N = length(Nums),
    Left = lists:seq(0, N-1),
    Right = lists:seq(0, N-1),
    LeftCount = count_left(Nums, k, Left, 0),
    RightCount = count_right(Nums, k, Right, 0),
    lists:foldl(fun(I, Acc) -> 
        if
            I > 0, I < N-1, lists:nth(I+1, LeftCount) >= k, lists:nth(I+1, RightCount) >= k -> [I | Acc];
            true -> Acc
        end
    end, [], lists:seq(0, N-1)).

count_left(_, _, _, _N) when _N >= length(_) -> [];
count_left(Nums, K, List, Index) ->
    case Index of
        0 -> [0 | count_left(Nums, K, List, Index + 1)];
        _ ->
            if
                Index - 1 >= 0, lists:nth(Index, Nums) <= lists:nth(Index - 1, Nums) -> 
                    [lists:nth(Index - 1, List) + 1 | count_left(Nums, K, List, Index + 1)];
                true -> [0 | count_left(Nums, K, List, Index + 1)]
            end
    end.

count_right(_, _, _, _N) when _N >= length(_) -> [];
count_right(Nums, K, List, Index) ->
    case Index of
        N when N == length(Nums) - 1 -> [0 | count_right(Nums, K, List, Index - 1)];
        _ ->
            if
                Index + 1 < length(Nums), lists:nth(Index, Nums) <= lists:nth(Index + 1, Nums) -> 
                    [lists:nth(Index + 1, List) + 1 | count_right(Nums, K, List, Index - 1)];
                true -> [0 | count_right(Nums, K, List, Index - 1)]
            end
    end.