-spec max_total_fruits(Fruits :: [[integer()]], StartPos :: integer(), K :: integer()) -> integer().
max_total_fruits(Fruits, StartPos, K) ->
    Prefix = lists:foldl(fun([Pos, Amount], Acc) -> 
                             maps:put(Pos, Amount, Acc) 
                         end, #{}, Fruits),
    Positions = lists:sort(maps:keys(Prefix)),
    N = length(Positions),
    PrefixSum = lists:foldl(fun(Pos, {Sum, Acc}) -> 
                                NewSum = Sum + maps:get(Pos, Prefix),
                                {NewSum, Acc#{Pos => NewSum}}
                            end, {0, #{}}, Positions),
    PrefixSumMap = element(2, PrefixSum),
    Max = 0,
    Left = find_left(Positions, StartPos),
    Right = find_right(Positions, StartPos),
    Max1 = search_max(PrefixSumMap, Positions, Left, Right, StartPos, K, Max),
    Max1.

find_left([], _) -> -1;
find_left([H|T], StartPos) ->
    if H =< StartPos -> find_left(T, StartPos);
       true -> -1
    end.

find_right([], _) -> -1;
find_right([H|T], StartPos) ->
    if H >= StartPos -> find_right(T, StartPos);
       true -> -1
    end.

search_max(_, _, -1, -1, _, _, Max) -> Max;
search_max(PrefixSumMap, Positions, Left, Right, StartPos, K, Max) ->
    NewMax = case Left =/= -1 andalso Right =/= -1 of
                 true ->
                     LeftPos = lists:nth(Left + 1, Positions),
                     RightPos = lists:nth(Right + 1, Positions),
                     Dist1 = StartPos - LeftPos,
                     Dist2 = RightPos - StartPos,
                     if Dist1 =< Dist2 ->
                            if 2 * Dist1 + Dist2 =< K ->
                                   Sum = get_sum(PrefixSumMap, Positions, Left, Right),
                                   max(Max, Sum);
                               true ->
                                   Max
                            end;
                        true ->
                            if 2 * Dist2 + Dist1 =< K ->
                                   Sum = get_sum(PrefixSumMap, Positions, Left, Right),
                                   max(Max, Sum);
                               true ->
                                   Max
                            end
                     end;
                 false ->
                     Max
             end,
    NewLeft = if Left =/= -1 -> Left - 1; true -> -1 end,
    NewRight = if Right =/= -1 -> Right + 1; true -> -1 end,
    if NewLeft =/= -1 orelse NewRight =/= -1 ->
           search_max(PrefixSumMap, Positions, NewLeft, NewRight, StartPos, K, NewMax);
       true ->
           NewMax
    end.

get_sum(PrefixSumMap, Positions, Left, Right) ->
    LeftPos = lists:nth(Left + 1, Positions),
    RightPos = lists:nth(Right + 1, Positions),
    RightSum = maps:get(RightPos, PrefixSumMap),
    if Left =:= 0 -> RightSum;
       true ->
           PrevPos = lists:nth(Left, Positions),
           PrevSum = maps:get(PrevPos, PrefixSumMap),
           RightSum - PrevSum
    end.