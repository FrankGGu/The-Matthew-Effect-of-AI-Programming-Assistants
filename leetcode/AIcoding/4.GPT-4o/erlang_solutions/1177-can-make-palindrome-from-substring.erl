-module(solution).
-export([can_make_pali_queries/3]).

can_make_pali_queries(S, Queries) ->
    CharCount = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(X) -> X + 1 end, fun() -> 1 end, Acc) end, #{} , S),
    counts_to_odds(CharCount, 0, lists:foldl(fun({L, R}, Acc) -> [can_make_pali_query(CharCount, L, R) | Acc] end, [], Queries)).

counts_to_odds(CharCount, OddCount, []) -> OddCount;
counts_to_odds(CharCount, OddCount, [{L, R} | T]) ->
    Counts = maps:to_list(maps:filter(fun(_, V) -> V rem 2 =:= 1 end, CharCount)),
    NewOddCount = OddCount + length(Counts),
    counts_to_odds(CharCount, NewOddCount, T).

can_make_pali_query(CharCount, L, R) ->
    SubCount = maps:fold(fun(_, V, Acc) -> Acc + V end, 0, maps:filter(fun(K, _) -> K >= L andalso K <= R end, CharCount)),
    if
        SubCount rem 2 =:= 0 -> true;
        SubCount div 2 < 1 -> true;
        true -> false
    end.