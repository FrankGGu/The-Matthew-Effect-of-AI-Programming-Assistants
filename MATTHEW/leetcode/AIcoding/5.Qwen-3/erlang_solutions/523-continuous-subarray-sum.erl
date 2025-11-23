-module(solution).
-export([has_continuous_subarray/2]).

has_continuous_subarray(Nums, k) ->
    Map = #{0 => -1},
    Sum = 0,
    has_continuous_subarray(Nums, k, Sum, Map).

has_continuous_subarray([], _, _, _) ->
    false;
has_continuous_subarray([H|T], K, Sum, Map) ->
    Sum1 = (Sum + H) rem K,
    case maps:find(Sum1, Map) of
        {ok, Index} when Index + 1 < length([H|T]) ->
            true;
        _ ->
            NewMap = maps:put(Sum1, length([H|T]) - 1, Map),
            has_continuous_subarray(T, K, Sum1, NewMap)
    end.