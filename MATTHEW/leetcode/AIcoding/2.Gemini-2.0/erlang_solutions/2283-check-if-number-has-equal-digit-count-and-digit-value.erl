-module(equal_digit_count).
-export([digit_count/1]).

digit_count(Num) ->
    S = integer_to_list(Num),
    Len = length(S),
    lists:all(fun(I) ->
                      Count = lists:foldl(fun(Digit, Acc) ->
                                                  case Digit =:= I + $0 of
                                                      true -> Acc + 1;
                                                      false -> Acc
                                                  end
                                          end, 0, S),
                      Count =:= list_to_integer([I + $0])
              end, lists:seq(0, Len - 1)).