-spec my_atoi(S :: unicode:unicode_binary()) -> integer().
my_atoi(S) ->
    S1 = string:strip(S),
    my_atoi(S1, 0, 1).

my_atoi([], Acc, Sign) -> Acc * Sign;
my_atoi([H | T], Acc, Sign) when H =:= $- -> my_atoi(T, Acc, -1);
my_atoi([H | T], Acc, Sign) when H =:= $+ -> my_atoi(T, Acc, Sign);
my_atoi([H | T], Acc, Sign) when H >= $0, H =< $9 ->
    NewAcc = Acc * 10 + (H - $0),
    my_atoi(T, NewAcc, Sign);
my_atoi(_, Acc, Sign) -> Acc * Sign.
