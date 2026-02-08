-module(solution).
-export([min_subarray_len/3]).

min_subarray_len(Target, Nums, K) ->
    TotalSum = lists:sum(Nums),
    FullCycles = Target div TotalSum,
    Remaining = Target rem TotalSum,
    if
        Remaining == 0 ->
            FullCycles * length(Nums);
        true ->
            case find_min_len(Nums ++ Nums, Remaining) of
                infinity ->
                    case FullCycles == 0 of
                        true -> 0;
                        false -> 
                            case find_min_len(Nums ++ Nums, Remaining + TotalSum) of
                                infinity -> 0;
                                Len -> (FullCycles - 1) * length(Nums) + Len
                            end
                    end;
                Len ->
                    FullCycles * length(Nums) + Len
            end
    end.

find_min_len(Nums, Target) ->
    find_min_len(Nums, Target, 0, 0, 0, infinity).

find_min_len([], _, _, Sum, Left, MinLen) when Sum >= Target ->
    MinLen;
find_min_len([], _, _, _, _, MinLen) ->
    MinLen;
find_min_len([Num | Rest], Target, Right, Sum, Left, MinLen) ->
    NewSum = Sum + Num,
    NewRight = Right + 1,
    case NewSum >= Target of
        true ->
            {NewLeft, NewSum1} = shrink_left(Rest, Target, Left, NewSum - Num, Num, Right),
            NewMinLen = min(MinLen, Right - NewLeft + 1),
            find_min_len(Rest, Target, NewRight, NewSum1, NewLeft, NewMinLen);
        false ->
            find_min_len(Rest, Target, NewRight, NewSum, Left, MinLen)
    end.

shrink_left(_, Target, Left, Sum, _, _) when Sum < Target ->
    {Left, Sum + hd(_)};
shrink_left([], _, Left, Sum, _, _) ->
    {Left, Sum};
shrink_left([Num | Rest], Target, Left, Sum, PrevNum, Right) ->
    case Sum - PrevNum >= Target of
        true ->
            shrink_left(Rest, Target, Left + 1, Sum - PrevNum, Num, Right);
        false ->
            {Left, Sum}
    end.