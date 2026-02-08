-module(solution).
-export([count_digits/1]).

count_digits(N) ->
    Count = fun(N, D) ->
        if
            D =:= 0 -> 0;
            N rem D =:= 0 -> 1 + Count(N, D + 1);
            true -> Count(N, D + 1)
        end
    end,
    Count(N, 1).