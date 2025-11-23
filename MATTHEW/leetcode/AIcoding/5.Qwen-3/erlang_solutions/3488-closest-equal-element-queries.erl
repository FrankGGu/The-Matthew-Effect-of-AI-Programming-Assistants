-module(closest_equal_element_queries).
-export([closest_equal/2]).

closest_equal(Numbers, Queries) ->
    N = length(Numbers),
    Map = build_map(Numbers, 0, #{}),
    [process_query(Num, Map, N) || Num <- Queries].

build_map([], _, Acc) -> Acc;
build_map([H|T], Index, Acc) ->
    Key = H,
    NewAcc = case maps:find(Key, Acc) of
        {ok, List} -> maps:put(Key, [Index | List], Acc);
        error -> maps:put(Key, [Index], Acc)
    end,
    build_map(T, Index + 1, NewAcc).

process_query(Query, Map, N) ->
    case maps:find(Query, Map) of
        {ok, Indices} ->
            lists:foldl(fun(Index, Min) ->
                Dist = abs(Index - Query),
                if Dist < Min -> Dist; true -> Min end
            end, N, Indices);
        error -> N
    end.