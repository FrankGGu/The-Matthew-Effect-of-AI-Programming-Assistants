-module(rfq).
-export([new/1, query/4]).

new(Elements) ->
    Map = lists:foldl(fun(E, Acc) ->
        Key = element(1, E),
        Value = element(2, E),
        maps:update_with(Key, fun(V) -> [Value | V] end, [Value], Acc)
    end, #{}, Elements).

query(Map, L, R, K) ->
    case maps:find(L, Map) of
        {ok, List} ->
            Count = length([X || X <- List, X >= L, X <= R, X == K]),
            Count;
        error ->
            0
    end.