-spec find_divisibility_array(Word :: unicode:chardata(), M :: integer()) -> [integer()].
find_divisibility_array(Word, M) ->
    find_divisibility_array_helper(Word, M, 0, []).

find_divisibility_array_helper([], _M, _CurrentRemainder, Acc) ->
    lists:reverse(Acc);
find_divisibility_array_helper([H | T], M, CurrentRemainder, Acc) ->
    Digit = H - $0,
    NewCurrentRemainder = (CurrentRemainder * 10 + Digit) rem M,
    DivValue = if NewCurrentRemainder == 0 -> 1;
                  true -> 0
               end,
    find_divisibility_array_helper(T, M, NewCurrentRemainder, [DivValue | Acc]).