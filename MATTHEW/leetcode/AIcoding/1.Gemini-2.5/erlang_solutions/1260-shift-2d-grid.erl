-module(solution).
-export([shift_grid/2]).

shift_grid(Grid, K) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    TotalElements = Rows * Cols,

    EffectiveK = K rem TotalElements,

    FlatList = lists:flatten(Grid),

    {Prefix, Suffix} = lists:split(TotalElements - EffectiveK, FlatList),
    ShiftedFlatList = Suffix ++ Prefix,

    reshape_list_to_grid(ShiftedFlatList, Cols, []).

reshape_list_to_grid([], _Cols, Acc) ->
    lists:reverse(Acc);
reshape_list_to_grid(List, Cols, Acc) ->
    {Row, Rest} = lists:split(Cols, List),
    reshape_list_to_grid(Rest, Cols, [Row | Acc]).