-record(list_node, {val, next}).

-spec find_min_max_nodes(Head :: #list_node{} | nil) -> [integer(), integer()].
find_min_max_nodes(nil) -> [-1, -1];
find_min_max_nodes(#list_node{next = nil}) -> [-1, -1];
find_min_max_nodes(#list_node{next = #list_node{next = nil}}) -> [-1, -1];

find_min_max_nodes(Head) ->
    InitialPrevVal = Head#list_node.val,
    InitialCurrNode = Head#list_node.next,
    InitialIndex = 2,

    CriticalPoints = find_critical_points_recursive(InitialPrevVal, InitialCurrNode, InitialIndex, []),

    case length(CriticalPoints) of
        L when L < 2 -> [-1, -1];
        _ ->
            FirstCP = hd(CriticalPoints),
            LastCP = lists:last(CriticalPoints),

            MaxDist = LastCP - FirstCP,
            MinDist = calculate_min_dist(CriticalPoints),

            [MinDist, MaxDist]
    end.

find_critical_points_recursive(PrevVal, #list_node{val = _CurrVal, next = nil}, _CurrIndex, Acc) ->
    lists:reverse(Acc);
find_critical_points_recursive(PrevVal, #list_node{val = CurrVal, next = NextNode}, CurrIndex, Acc) ->
    NextVal = NextNode#list_node.val,

    IsLocalMin = (CurrVal < PrevVal and CurrVal < NextVal),
    IsLocalMax = (CurrVal > PrevVal and CurrVal > NextVal),

    NewAcc = if
        IsLocalMin or IsLocalMax -> [CurrIndex | Acc];
        true -> Acc
    end,

    find_critical_points_recursive(CurrVal, NextNode, CurrIndex + 1, NewAcc).

calculate_min_dist([_]) ->
    error(badarg); 
calculate_min_dist([H1, H2 | T]) ->
    MinDist = H2 - H1,
    calculate_min_dist_acc(T, H2, MinDist).

calculate_min_dist_acc([], _PrevCP, MinDist) ->
    MinDist;
calculate_min_dist_acc([H | T], PrevCP, CurrentMinDist) ->
    NewMinDist = min(CurrentMinDist, H - PrevCP),
    calculate_min_dist_acc(T, H, NewMinDist).