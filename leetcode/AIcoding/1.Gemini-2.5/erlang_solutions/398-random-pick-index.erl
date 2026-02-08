-module(solution).
-export([new/1, pick/2]).

-record(solution_state, {indices_map :: map()}).

new(Nums) ->
    IndicesMap = build_indices_map(Nums),
    #solution_state{indices_map = IndicesMap}.

pick(State, Target) ->
    Indices = maps:get(Target, State#solution_state.indices_map),
    ListLen = length(Indices),
    RandomIndexInList = rand:uniform(ListLen),
    lists:nth(RandomIndexInList, Indices).

build_indices_map(Nums) ->
    {TempMap, _} = lists:foldl(
        fun(Num, {AccMap, Index}) ->
            ExistingIndices = maps:get(Num, AccMap, []),
            NewIndices = [Index | ExistingIndices],
            {maps:put(Num, NewIndices, AccMap), Index + 1}
        end,
        {#{}, 0},
        Nums
    ),
    maps:map(fun(_Key, Value) -> lists:reverse(Value) end, TempMap).