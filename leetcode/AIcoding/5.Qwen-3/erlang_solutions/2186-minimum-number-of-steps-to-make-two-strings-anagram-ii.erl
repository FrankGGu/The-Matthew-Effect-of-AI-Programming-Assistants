-module(minimum_number_of_steps_to_make_two_strings_anagram_ii).
-export([minSteps/2]).

minSteps(S, T) ->
    CountS = count_chars(S),
    CountT = count_chars(T),
    Diff = maps:fold(fun(Key, Val, Acc) ->
                        case maps:get(Key, CountT, 0) of
                            Val -> Acc;
                            TVal -> Acc + abs(Val - TVal)
                        end
                    end, 0, CountS),
    maps:fold(fun(Key, Val, Acc) ->
                  case maps:get(Key, CountS, 0) of
                      Val -> Acc;
                      SVal -> Acc + abs(Val - SVal)
                  end
              end, Diff, CountT).

count_chars(Str) ->
    count_chars(Str, #{}).

count_chars([], Acc) ->
    Acc;
count_chars([C | Rest], Acc) ->
    NewAcc = maps:update_with(C, fun(V) -> V + 1 end, 1, Acc),
    count_chars(Rest, NewAcc).