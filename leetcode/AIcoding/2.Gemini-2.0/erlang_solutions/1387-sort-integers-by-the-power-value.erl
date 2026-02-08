-module(sort_by_power).
-export([getK/3]).

power(1) -> 0;
power(N) when N rem 2 == 0 -> 1 + power(N div 2);
power(N) -> 1 + power(3 * N + 1).

getK(Lo, Hi, K) ->
    List = lists:seq(Lo, Hi),
    PowerList = [{power(X), X} || X <- List],
    SortedPowerList = lists:keysort(1, PowerList),
    {_, Result} = lists:nth(K, SortedPowerList),
    Result.