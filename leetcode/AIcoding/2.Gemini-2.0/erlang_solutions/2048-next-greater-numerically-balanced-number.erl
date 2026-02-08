-module(next_greater_numerically_balanced_number).
-export([next_beautiful_number/1]).

next_beautiful_number(N) ->
    find_next_beautiful(N + 1).

find_next_beautiful(N) ->
    Digits = integer_to_list(N),
    Len = length(Digits),
    case is_beautiful(Digits) of
        true ->
            N;
        false ->
            find_next_beautiful(N + 1)
    end.

is_beautiful(Digits) ->
    Counts = lists:foldl(fun(Digit, Acc) ->
                                  try
                                      Acc#{Digit => maps:get(Digit, Acc) + 1}
                                  catch
                                      _:_ ->
                                          Acc#{Digit => 1}
                                  end
                              end, #{}, Digits),
    lists:all(fun({Digit, Count}) ->
                      Digit =:= Count - $0
              end, maps:to_list(Counts)).