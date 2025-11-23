-module(kth_largest).
-export([new/2, add/2]).

new(K, NumList) ->
    Sorted = lists:sort(NumList),
    {K, Sorted}.

add(X, {K, List}) ->
    Inserted = lists:insert(X, List),
    Sorted = lists:sort(Inserted),
    Index = length(Sorted) - K,
    lists:nth(Index + 1, Sorted).