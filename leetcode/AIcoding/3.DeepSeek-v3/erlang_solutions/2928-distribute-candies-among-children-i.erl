-spec distribute_candies(Candies :: integer(), Limit :: integer()) -> integer().
distribute_candies(Candies, Limit) ->
    count(0, 0, 0, Candies, Limit).

count(A, B, C, 0, _Limit) when A >= 0, B >= 0, C >= 0 -> 1;
count(_A, _B, _C, Candies, _Limit) when Candies < 0 -> 0;
count(A, B, C, Candies, Limit) when A > Limit; B > Limit; C > Limit -> 0;
count(A, B, C, Candies, Limit) ->
    count(A + 1, B, C, Candies - 1, Limit) +
    count(A, B + 1, C, Candies - 1, Limit) +
    count(A, B, C + 1, Candies - 1, Limit).