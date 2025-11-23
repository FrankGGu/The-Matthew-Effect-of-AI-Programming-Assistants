-module(solution).
-export([max_pair_sum/1]).

max_pair_sum(Nums) ->
    GroupedMap = group_by_max_digit(Nums),
    lists:foldl(fun(List, AccMaxSum) ->
                    case length(List) >= 2 of
                        true ->
                            SortedList = lists:sort(fun(A, B) -> A > B end, List),
                            CurrentSum = hd(SortedList) + hd(tl(SortedList)),
                            max(AccMaxSum, CurrentSum);
                        false ->
                            AccMaxSum
                    end
                end, -1, maps:values(GroupedMap)).

group_by_max_digit(Nums) ->
    lists:foldl(fun(Num, AccMap) ->
                    MaxD = max_digit(Num),
                    maps:update_with(MaxD, fun(List) -> [Num | List] end, [Num], AccMap)
                end, #{} , Nums).

max_digit(N) when N < 10 -> N;
max_digit(N) -> max(N rem 10, max_digit(N div 10)).