-module(solution).
-export([min_operations/1]).

min_operations(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> dict:update_counter(N, 1, Acc) end, dict:new(), Nums),
    min_operations(Count, 0).

min_operations(Dict, Acc) ->
    case dict:is_empty(Dict) of
        true -> Acc;
        false ->
            {Key, Value} = dict:take_any(Dict),
            if
                Value < 2 -> -1;
                true ->
                    NewValue = Value - 2,
                    if
                        NewValue == 0 -> min_operations(Dict, Acc + 1);
                        true -> min_operations(dict:store(Key, NewValue, Dict), Acc + 1)
                    end
            end
    end.