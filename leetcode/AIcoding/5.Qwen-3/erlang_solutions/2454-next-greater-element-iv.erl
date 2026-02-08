-module(solution).
-export([next_greater_element/1]).

next_greater_element(Nums) ->
    next_greater_element(Nums, []).

next_greater_element([], _) ->
    [];
next_greater_element([H | T], Stack) ->
    Result = case Stack of
        [] -> -1;
        _ ->
            lists:foldl(fun({Val, Index}, Acc) ->
                                if Val > H -> Index;
                                   true -> Acc
                                end
                            end, -1, Stack)
    end,
    NewStack = [{H, length(Nums) - length(T) - 1} | Stack],
    [Result | next_greater_element(T, NewStack)].