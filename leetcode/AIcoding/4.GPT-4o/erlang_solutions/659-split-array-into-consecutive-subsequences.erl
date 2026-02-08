-module(solution).
-export([is_possible/1]).

is_possible(Nums) ->
    is_possible(Nums, dict:new(), 0).

is_possible([], _, 0) ->
    true;
is_possible([], _, _) ->
    false;
is_possible(Nums, CountMap, 0) ->
    case dict:to_list(CountMap) of
        [] -> true;
        _ -> is_possible(Nums, CountMap, 1)
    end;
is_possible([H | T], CountMap, Count) ->
    case dict:find(H, CountMap) of
        {ok, CountValue} when CountValue > 0 ->
            NewCountMap = dict:update(H, fun(X) -> X - 1 end, CountMap),
            is_possible(T, NewCountMap, Count);
        _ ->
            if Count =< 0 ->
                is_possible(T, CountMap, Count + 1);
            true ->
                false
            end
    end.