-module(solution).
-export([minimumDifference/1]).

minimumDifference(Nums) ->
    Total = lists:sum(Nums),
    N = length(Nums) div 2,
    Left = lists:sublist(Nums, N),
    Right = lists:nthtail(N, Nums),
    LeftSums = get_sums(Left),
    RightSums = get_sums(Right),
    MinDiff = find_min_diff(LeftSums, RightSums, Total),
    MinDiff.

get_sums(List) ->
    N = length(List),
    Sums = array:new([{size, N + 1}, {default, []}]),
    lists:foldl(fun(_, Acc) -> Acc end, Sums, lists:seq(1, N + 1)),
    lists:foldl(fun(I, Acc) ->
        array:set(I, get_combinations(List, I), Acc
    end, Sums, lists:seq(1, N)).

get_combinations(List, K) ->
    Combinations = combinations(List, K),
    lists:map(fun(C) -> lists:sum(C) end, Combinations).

combinations(List, K) ->
    case K of
        0 -> [[]];
        _ when K > length(List) -> [];
        _ ->
            [H | T] = List,
            lists:append(
                lists:map(fun(C) -> [H | C] end, combinations(T, K - 1)),
                combinations(T, K)
            )
    end.

find_min_diff(LeftSums, RightSums, Total) ->
    MinDiff = infinity,
    lists:foldl(fun(K, Acc) ->
        Left = array:get(K, LeftSums),
        Right = array:get(length(RightSums) - K - 1, RightSums),
        lists:sort(Left),
        lists:sort(Right),
        lists:foldl(fun(L, InnerAcc) ->
            Target = (Total div 2) - L,
            case binary_search(Right, Target) of
                not_found -> InnerAcc;
                R ->
                    CurrentDiff = abs(Total - 2 * (L + R)),
                    if CurrentDiff < InnerAcc -> CurrentDiff; true -> InnerAcc end
            end
        end, Acc, Left)
    end, MinDiff, lists:seq(0, length(LeftSums) - 1)).

binary_search(List, Target) ->
    binary_search(List, Target, 1, length(List)).

binary_search(List, Target, Low, High) ->
    if
        Low > High -> not_found;
        true ->
            Mid = (Low + High) div 2,
            MidVal = lists:nth(Mid, List),
            if
                MidVal == Target -> MidVal;
                MidVal < Target -> binary_search(List, Target, Mid + 1, High);
                true -> binary_search(List, Target, Low, Mid - 1)
            end
    end.