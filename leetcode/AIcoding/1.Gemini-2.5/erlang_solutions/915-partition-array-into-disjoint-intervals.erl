-module(solution).
-export([partitionDisjoint/1]).

-spec partitionDisjoint(Nums :: [integer()]) -> integer().
partitionDisjoint(Nums) ->
    MaxLeft = calculate_max_left(Nums),
    MinRight = calculate_min_right(Nums),

    find_partition_index_recursive(MaxLeft, tl(MinRight), 1).

calculate_max_left(Nums) ->
    calculate_max_left_acc(Nums, -1000000001, []).

calculate_max_left_acc([], _, Acc) ->
    lists:reverse(Acc);
calculate_max_left_acc([H|T], CurrentMax, Acc) ->
    NewMax = max(CurrentMax, H),
    calculate_max_left_acc(T, NewMax, [NewMax|Acc]).

calculate_min_right(Nums) ->
    calculate_min_right_acc(lists:reverse(Nums), 1000000001, []).

calculate_min_right_acc([], _, Acc) ->
    Acc;
calculate_min_right_acc([H|T], CurrentMin, Acc) ->
    NewMin = min(CurrentMin, H),
    calculate_min_right_acc(T, NewMin, [NewMin|Acc]).

find_partition_index_recursive([MLH|_MLT], [MRH|_MRT], CurrentLength) ->
    if
        MLH =< MRH -> CurrentLength;
        true -> find_partition_index_recursive(_MLT, _MRT, CurrentLength + 1)
    end.