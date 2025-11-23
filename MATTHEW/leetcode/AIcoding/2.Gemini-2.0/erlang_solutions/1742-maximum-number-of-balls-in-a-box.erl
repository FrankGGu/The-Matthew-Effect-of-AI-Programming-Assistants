-module(maximum_balls).
-export([max_balls/2]).

max_balls(Low, High) ->
    lists:foldl(
        fun(N, Acc) ->
            Sum = sum_digits(N),
            case maps:is_key(Sum, Acc) of
                true ->
                    maps:update(Sum, maps:get(Sum, Acc) + 1, Acc);
                false ->
                    maps:put(Sum, 1, Acc)
            end
        end,
        #{},
        lists:seq(Low, High)
    )
    |> maps:values()
    |> lists:max().

sum_digits(N) ->
    sum_digits_helper(N, 0).

sum_digits_helper(0, Sum) ->
    Sum;
sum_digits_helper(N, Sum) ->
    Digit = N rem 10,
    sum_digits_helper(N div 10, Sum + Digit).