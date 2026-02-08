-module(solution).
-export([num_balanced_permutations/1]).

num_balanced_permutations(S) ->
    Count = count_balanced(S),
    Count.

count_balanced(S) ->
    N = length(S),
    case N rem 2 of
        1 -> 0;
        _ ->
            Half = N div 2,
            Counts = lists:foldl(fun(C, Acc) -> dict:update_counter(C, 1, Acc) end, dict:new(), S),
            Values = dict:values(Counts),
            Factorial = fun(N) -> factorial(N) end,
            Total = lists:foldl(fun(V, Acc) -> Acc * Factorial(V) end, 1, Values),
            Factorial(N) div (Total * Factorial(Half) * Factorial(Half))
    end.

factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1).