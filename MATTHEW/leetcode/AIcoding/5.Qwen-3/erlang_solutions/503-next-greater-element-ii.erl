-module(nge_ii).
-export([next_greater_element/1]).

next_greater_element(Nums) ->
    N = length(Nums),
    Result = lists:duplicate(N, -1),
    Stack = [],
    for_loop(0, N * 2, Nums, Result, Stack).

for_loop(I, Max, Nums, Result, Stack) when I < Max ->
    Index = I rem N,
    Value = lists:nth(Index + 1, Nums),
    case Stack of
        [] ->
            for_loop(I + 1, Max, Nums, Result, [Index]);
        _ ->
            case lists:last(Stack) of
                TopIndex when Value > lists:nth(TopIndex + 1, Nums) ->
                    Result1 = lists:sublist(Result, TopIndex) ++ [Value] ++ lists:nthtail(TopIndex + 1, Result),
                    for_loop(I, Max, Nums, Result1, lists:droplast(Stack));
                _ ->
                    for_loop(I + 1, Max, Nums, Result, [Index | Stack])
            end
    end;
for_loop(_, _, _, Result, _) ->
    Result.