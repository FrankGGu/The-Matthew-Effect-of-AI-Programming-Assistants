-module(check_if_digits_equal_string_operations2).
-export([digit_count/1]).

digit_count(S) ->
    Len = length(S),
    Counts = lists:foldl(fun(C, Acc) ->
                                    Digit = C - $0,
                                    case lists:keyfind(Digit, 1, Acc) of
                                        false ->
                                            [{Digit, 1} | Acc];
                                        {Digit, Count} ->
                                            lists:keyreplace(Digit, 1, Acc, {Digit, Count + 1})
                                    end
                            end, [], string:to_list(S)),
    lists:all(fun({Digit, Count}) ->
                      try
                          Num = list_to_integer(integer_to_list(Digit)),
                          Num < Len andalso
                              case lists:keyfind(Num, 1, Counts) of
                                  {Num, ExpectedCount} ->
                                      Count == ExpectedCount;
                                  false ->
                                      Count == 0
                              end
                      catch
                          _:_ ->
                              false
                      end
              end, Counts).