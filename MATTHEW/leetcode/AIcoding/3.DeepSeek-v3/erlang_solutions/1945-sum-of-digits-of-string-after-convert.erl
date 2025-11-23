-spec get_lucky(S :: unicode:unicode_binary(), K :: integer()) -> integer().
get_lucky(S, K) ->
    Initial = lists:foldl(fun(Char, Acc) ->
                              Num = Char - $a + 1,
                              if Num >= 10 -> Acc + (Num div 10) + (Num rem 10);
                                 true -> Acc + Num
                              end
                          end, 0, unicode:characters_to_list(S)),
    transform(Initial, K - 1).

transform(Number, 0) -> Number;
transform(Number, K) when K > 0 ->
    Sum = lists:foldl(fun(Digit, Acc) -> Acc + (Digit - $0) end, 0, integer_to_list(Number)),
    transform(Sum, K - 1).