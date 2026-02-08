-module(solution).
-export([rotateGrid/2]).

rotateGrid(Grid, K) ->
    M = length(Grid),
    N = length(hd(Grid)),

    ArrayGrid = array:from_list(lists:map(fun array:from_list/1, Grid)),

    NumLayers = min(M, N) div 2,

    FinalArrayGrid = rotate_layers(0, NumLayers, M, N, K, ArrayGrid),

    lists:map(fun array:to_list/1, array:to_list(FinalArrayGrid)).

rotate_layers(LayerIdx, NumLayers, M, N, K, CurrentArrayGrid) when LayerIdx < NumLayers ->
    R1 = LayerIdx,
    C1 = LayerIdx,
    R2 = M - 1 - LayerIdx,
    C2 = N - 1 - LayerIdx,

    LayerElements = extract_layer_elements(R1, C1, R2, C2, CurrentArrayGrid, []),

    Len = length(LayerElements),

    NewArrayGrid = 
        if
            Len == 0 -> 
                CurrentArrayGrid;
            true ->
                EffectiveK = K rem Len,
                RotatedElements = lists:nthtail(EffectiveK, LayerElements) ++ lists:sublist(LayerElements, EffectiveK),

                place_layer_elements(R1, C1, R2, C2, RotatedElements, CurrentArrayGrid)
        end,

    rotate_layers(LayerIdx + 1, NumLayers, M, N, K, NewArrayGrid);
rotate_layers(_LayerIdx, _NumLayers, _M, _N, _K, CurrentArrayGrid) ->
    CurrentArrayGrid.

get_element(R, C, ArrayGrid) ->
    array:get(C, array:get(R, ArrayGrid)).

set_element(R, C, Value, ArrayGrid) ->
    NewRow = array:set(C, Value, array:get(R, ArrayGrid)),
    array:set(R, NewRow, ArrayGrid).

extract_layer_elements(R1, C1, R2, C2, ArrayGrid, Acc) ->
    Acc1 = extract_segment_inc(C1, C2, fun(C_val) -> get_element(R1, C_val, ArrayGrid) end, Acc),
    Acc2 = extract_segment_inc(R1 + 1, R2, fun(R_val) -> get_element(R_val, C2, ArrayGrid) end, Acc1),
    Acc3 = extract_segment_dec(C2 - 1, C1, fun(C_val) -> get_element(R2, C_val, ArrayGrid) end, Acc2),
    Acc4 = extract_segment_dec(R2 - 1, R1 + 1, fun(R_val) -> get_element(R_val, C1, ArrayGrid) end, Acc3),

    lists:reverse(Acc4).

extract_segment_inc(CurrentIdx, EndIdx, GetValFun, Acc) when CurrentIdx =< EndIdx ->
    Val = GetValFun(CurrentIdx),
    extract_segment_inc(CurrentIdx + 1, EndIdx, GetValFun, [Val | Acc]);
extract_segment_inc(_CurrentIdx, _EndIdx, _GetValFun, Acc) ->
    Acc.

extract_segment_dec(CurrentIdx, EndIdx, GetValFun, Acc) when CurrentIdx >= EndIdx ->
    Val = GetValFun(CurrentIdx),
    extract_segment_dec(CurrentIdx - 1, EndIdx, GetValFun, [Val | Acc]);
extract_segment_dec(_CurrentIdx, _EndIdx, _GetValFun, Acc) ->
    Acc.

place_layer_elements(R1, C1, R2, C2, RotatedElements, CurrentArrayGrid) ->
    {ArrayGrid1, RemainingElements1} = place_segment_inc_optimized(C1, C2, RotatedElements, 
                                                                  fun(C_val, Val, Arr) -> set_element(R1, C_val, Val, Arr) end, CurrentArrayGrid),
    {ArrayGrid2, RemainingElements2} = place_segment_inc_optimized(R1 + 1, R2, RemainingElements1, 
                                                                  fun(R_val, Val, Arr) -> set_element(R_val, C2, Val, Arr) end, ArrayGrid1),
    {ArrayGrid3, RemainingElements3} = place_segment_dec_optimized(C2 - 1, C1, RemainingElements2, 
                                                                  fun(C_val, Val, Arr) -> set_element(R2, C_val, Val, Arr) end, ArrayGrid2),
    {ArrayGrid4, _RemainingElements4} = place_segment_dec_optimized(R2 - 1, R1 + 1, RemainingElements3, 
                                                                  fun(R_val, Val, Arr) -> set_element(R_val, C1, Val, Arr) end, ArrayGrid3),

    ArrayGrid4.

place_segment_inc_optimized(CurrentIdx, EndIdx, [Val | RestElements], SetValFun, CurrentArrayGrid) when CurrentIdx =< EndIdx ->
    NewArrayGrid = SetValFun(CurrentIdx, Val, CurrentArrayGrid),
    place_segment_inc_optimized(CurrentIdx + 1, EndIdx, RestElements, SetValFun, NewArrayGrid);
place_segment_inc_optimized(_CurrentIdx, _EndIdx, RemainingElements, _SetValFun, CurrentArrayGrid) ->
    {CurrentArrayGrid, RemainingElements}.

place_segment_dec_optimized(CurrentIdx, EndIdx, [Val | RestElements], SetValFun, CurrentArrayGrid) when CurrentIdx >= EndIdx ->
    NewArrayGrid = SetValFun(CurrentIdx, Val, CurrentArrayGrid),
    place_segment_dec_optimized(CurrentIdx - 1, EndIdx, RestElements, SetValFun, NewArrayGrid);
place_segment_dec_optimized(_CurrentIdx, _EndIdx, RemainingElements, _SetValFun, CurrentArrayGrid) ->
    {CurrentArrayGrid, RemainingElements}.