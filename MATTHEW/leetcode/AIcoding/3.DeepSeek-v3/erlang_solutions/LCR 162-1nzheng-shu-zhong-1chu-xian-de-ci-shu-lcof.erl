-spec count_digit_one(N :: integer()) -> integer().
count_digit_one(N) ->
    count_digit_one(N, 1, 0).

count_digit_one(N, digit, count) when digit =< N ->
    high = N div (digit * 10),
    current = (N div digit) rem 10,
    low = N rem digit,
    NewCount = count + high * digit + 
               if 
                   current > 1 -> digit;
                   current == 1 -> low + 1;
                   true -> 0
               end,
    count_digit_one(N, digit * 10, NewCount);
count_digit_one(_, _, count) ->
    count.