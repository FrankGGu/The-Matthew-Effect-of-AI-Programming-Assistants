-module(solution).
-export([sort_array_by_parity_ii/1]).

sort_array_by_parity_ii(Arr) ->
    {Even, Odd} = lists:partition(fun(X) -> X rem 2 == 0 end, Arr),
    merge(Even, Odd, []).

merge([], [], Result) ->
    lists:reverse(Result);
merge([], [H|T], Result) ->
    merge([], T, [H | Result]);
merge([H|T], [], Result) ->
    merge(T, [], [H | Result]);
merge([H|T1], [K|T2], Result) ->
    merge(T1, T2, [H, K | Result]).