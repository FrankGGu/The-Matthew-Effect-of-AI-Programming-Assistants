-module(solution).
-export([maxHeight/1]).

maxHeight(Cuboids) ->
    SortedDimsCuboids = lists:map(fun(Cuboid) -> lists:sort(Cuboid) end, Cuboids),
    SortedCuboidsList = lists:sort(fun([L1, W1, H1], [L2, W2, H2]) ->
                                           if
                                               L1 < L2 -> true;
                                               L1 == L2 ->
                                                   if
                                                       W1 < W2 -> true;
                                                       W1 == W2 -> H1 < H2;
                                                       true -> false
                                                   end;
                                               true -> false
                                           end
                                   end, SortedDimsCuboids),

    N = length(SortedCuboidsList),

    if N == 0 -> 0; true -> ok end,

    CuboidsArray = array:from_list(SortedCuboidsList),

    DP_Array = array:new([{size, N}, {fixed, true}]),

    DP_Array_Init = lists:foldl(fun({Idx, Cuboid}, Arr) ->
                                        [_,_,H] = Cuboid,
                                        array:set(Idx, H, Arr)
                                end, DP_Array, lists:zip(lists:seq(0, N-1), SortedCuboidsList)),

    FinalDP_Array = calculate_dp_array(0, N, CuboidsArray, DP_Array_Init),

    lists:max([0 | array:to_list(FinalDP_Array)]).

calculate_dp_array(I, N, CuboidsArray, CurrentDP_Array) when I < N ->
    CurrentCuboid = array:get(I, CuboidsArray),
    [CL, CW, CH] = CurrentCuboid,

    MaxHeightForI = CH,

    UpdatedMaxHeightForI = lists:foldl(fun(J, AccMaxH) ->
                                               PrevCuboid = array:get(J, CuboidsArray),
                                               [PL, PW, PH] = PrevCuboid,

                                               if
                                                   PL =< CL andalso PW =< CW andalso PH =< CH ->
                                                       PrevDPHeight = array:get(J, CurrentDP_Array),
                                                       max(AccMaxH, PrevDPHeight + CH);
                                                   true ->
                                                       AccMaxH
                                               end
                                       end, MaxHeightForI, lists:seq(0, I-1)),

    NewDP_Array = array:set(I, UpdatedMaxHeightForI, CurrentDP_Array),

    calculate_dp_array(I + 1, N, CuboidsArray, NewDP_Array);
calculate_dp_array(N, N, _CuboidsArray, CurrentDP_Array) ->
    CurrentDP_Array.