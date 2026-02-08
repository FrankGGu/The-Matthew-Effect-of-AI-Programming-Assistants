-module(solution).
-export([findIntegers/1]).

findIntegers(N) ->
    Fib = [1, 2],
    lists:foldl(fun(_, Acc) -> [hd(Acc) + hd(tl(Acc)) | Acc] end, Fib, lists:seq(3, 32)),
    FibList = lists:reverse(Fib),
    count_without_consecutive_ones(N, FibList).

count_without_consecutive_ones(0, _) -> 1;
count_without_consecutive_ones(N, Fib) ->
    Count = count(N, Fib, 0, 0),
    Count + 1.

count(N, _, 32, _) -> 0;
count(N, Fib, i, 0) ->
    case (N band (1 bsl i)) of
        0 -> count(N, Fib, i + 1, 0);
        _ -> lists:nth(i + 1, Fib) + count(N, Fib, i + 1, 1)
    end;
count(N, Fib, i, 1) ->
    0.