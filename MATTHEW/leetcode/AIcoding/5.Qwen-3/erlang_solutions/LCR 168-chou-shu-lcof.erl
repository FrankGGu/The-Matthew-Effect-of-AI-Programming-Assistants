-module(ugly).
-export([nth_ugly_number/1]).

nth_ugly_number(N) ->
    nth_ugly_number(N, 1, 1, [], [1]).

nth_ugly_number(N, Count, Index, Ugly, _Nexts) when Count == N ->
    lists:last(Ugly);

nth_ugly_number(N, Count, Index, Ugly, Nexts) ->
    Next = lists:min(Nexts),
    NewUgly = Ugly ++ [Next],
    NewNexts = lists:map(fun(X) -> if X == Next -> X * lists:nth(Index, Ugly); true -> X end end, Nexts),
    nth_ugly_number(N, Count + 1, Index + 1, NewUgly, NewNexts).