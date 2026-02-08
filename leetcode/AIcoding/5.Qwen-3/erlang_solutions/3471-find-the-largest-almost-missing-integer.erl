-module(largest_almost_missing).
-export([find_largest_almost_missing/1]).

find_largest_almost_missing(Nums) ->
    Sorted = lists:sort(Nums),
    find_largest_almost_missing(Sorted, 0, -1).

find_largest_almost_missing([], _, Result) ->
    Result;
find_largest_almost_missing([H | T], Index, Result) ->
    if
        H > Index + 1 ->
            NewResult = if Result == -1 -> H; true -> max(Result, H) end,
            find_largest_almost_missing(T, Index + 1, NewResult);
        true ->
            find_largest_almost_missing(T, Index + 1, Result)
    end.