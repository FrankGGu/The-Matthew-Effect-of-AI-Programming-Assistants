-spec minimum_sum(Num :: integer()) -> integer().
minimum_sum(Num) ->
    minimum_sum(Num, 0).

minimum_sum(Num, Steps) ->
    if
        Num < 10 -> Steps;
        true ->
            NewNum = digit_sum(Num),
            minimum_sum(NewNum, Steps + 1)
    end.

digit_sum(N) ->
    digit_sum(N, 0).

digit_sum(0, Sum) -> Sum;
digit_sum(N, Sum) ->
    Digit = N rem 10,
    digit_sum(N div 10, Sum + Digit).