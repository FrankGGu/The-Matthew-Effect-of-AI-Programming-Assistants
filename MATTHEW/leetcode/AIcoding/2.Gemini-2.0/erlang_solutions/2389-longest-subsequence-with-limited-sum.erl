-module(longest_subsequence).
-export([solve/2]).

solve(Nums, Queries) ->
    SortedNums = lists:sort(Nums),
    lists:map(fun(Query) -> find_length(SortedNums, Query, 0, 0) end, Queries).

find_length([], _Query, _Sum, Length) ->
    Length;
find_length([H|T], Query, Sum, Length) ->
    if Sum + H =< Query ->
        find_length(T, Query, Sum + H, Length + 1);
    true ->
        Length
    end.