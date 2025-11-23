-module(solution).
-export([longestWellPerformingInterval/1]).

longestWellPerformingInterval(Hours) ->
    N = length(Hours),

    TransformedHours = lists:map(fun(H) -> if H > 8 then 1 else -1 end end, Hours),

    {P_map, _} = lists:foldl(
        fun(Val, {AccMap, CurrentSum, Index}) ->
            NewSum = CurrentSum + Val,
            NewMap = maps:put(Index + 1, NewSum, AccMap),
            {NewMap, NewSum, Index + 1}
        end,
        {maps:put(0, 0, maps:new()), 0, 0},
        TransformedHours
    ),

    Stack = lists:foldl(
        fun(I, CurrentStack) ->
            case CurrentStack of
                [] ->
                    [I];
                [TopI | _] when maps:get(I, P_map) < maps:get(TopI, P_map) ->
                    [I | CurrentStack];
                _ ->
                    CurrentStack
            end
        end,
        [],
        lists:seq(0, N)
    ),

    MaxLenResult = lists:foldl(
        fun(I, {CurrentMaxLen, CurrentStack}) ->
            calculate_max_len_inner(I, CurrentMaxLen, CurrentStack, P_map)
        end,
        {0, Stack},
        lists:seq(N, 0, -1)
    ),
    element(1, MaxLenResult).

calculate_max_len_inner(I, CurrentMaxLen, Stack, P_map) ->
    case Stack of
        [] ->
            {CurrentMaxLen, []};
        [TopI | RestStack] when maps:get(I, P_map) > maps:get(TopI, P_map) ->
            NewMaxLen = max(CurrentMaxLen, I - TopI),
            calculate_max_len_inner(I, NewMaxLen, RestStack, P_map);
        _ ->
            {CurrentMaxLen, Stack}
    end.