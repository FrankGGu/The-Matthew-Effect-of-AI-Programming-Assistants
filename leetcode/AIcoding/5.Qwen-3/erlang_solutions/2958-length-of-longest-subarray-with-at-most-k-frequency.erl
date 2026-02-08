-module(solution).
-export([find_length/2]).

find_length(Nums, K) ->
    Map = maps:new(),
    MaxLength = 0,
    Left = 0,
    find_length(Nums, K, Map, MaxLength, Left).

find_length([], _, _, MaxLength, _) ->
    MaxLength;
find_length([H | T], K, Map, MaxLength, Left) ->
    NewMap = maps:update_with(H, fun(V) -> V + 1 end, 1, Map),
    case maps:get(H, NewMap) of
        V when V > K ->
            find_length(T, K, NewMap, MaxLength, Left + 1);
        _ ->
            NewLength = erlang:element(2, lists:keyfind(H, 1, maps:to_list(NewMap))),
            NewMaxLength = max(MaxLength, length(T) - Left + 1),
            find_length(T, K, NewMap, NewMaxLength, Left)
    end.