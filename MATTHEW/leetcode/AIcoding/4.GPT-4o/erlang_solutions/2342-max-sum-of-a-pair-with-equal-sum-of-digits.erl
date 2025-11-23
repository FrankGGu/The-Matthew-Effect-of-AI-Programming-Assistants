-module(solution).
-export([maximum_sum/1]).

maximum_sum(List) ->
    DigitsSumMap = maps:fold(fun(X, Acc) ->
        Sum = digit_sum(X),
        case maps:find(Sum, Acc) of
            {ok, Prev} -> maps:update(Sum, max(X + Prev, Prev), Acc);
            _ -> maps:put(Sum, X, Acc)
        end
    end, maps:new(), List),
    maps:fold(fun(_, V, Acc) -> max(Acc, V) end, 0, DigitsSumMap).

digit_sum(N) when N < 10 -> N;
digit_sum(N) -> digit_sum(N div 10) + (N rem 10).