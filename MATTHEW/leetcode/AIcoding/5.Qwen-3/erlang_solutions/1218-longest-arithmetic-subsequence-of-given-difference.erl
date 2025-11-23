-module(longest_arithmetic_subsequence).
-export([length_of_lis/2]).

length_of_lis(A, D) ->
    maps:fold(fun(_, V, Acc) -> max(V, Acc) end, 0, length_of_lis(A, D, #{})).

length_of_lis([], _, Map) ->
    Map;
length_of_lis([H | T], D, Map) ->
    Prev = H - D,
    Count = case maps:find(Prev, Map) of
                {ok, C} -> C + 1;
                error -> 1
            end,
    NewMap = maps:put(H, Count, Map),
    length_of_lis(T, D, NewMap).