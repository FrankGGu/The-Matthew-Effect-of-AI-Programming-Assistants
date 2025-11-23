-module(check_array_pairs_divisible_by_k).
-export([can_arrange/2]).

can_arrange(Arr, K) ->
    Reminders = lists:map(fun(X) -> (X rem K + K) rem K end, Arr),
    Counts = lists:foldl(fun(X, Acc) ->
                                  case maps:is_key(X, Acc) of
                                      true -> maps:update(X, maps:get(X, Acc) + 1, Acc);
                                      false -> maps:put(X, 1, Acc)
                                  end
                          end, #{}, Reminders),
    check_pairs(Counts, K).

check_pairs(Counts, K) ->
    case maps:is_key(0, Counts) of
        true ->
            case maps:get(0, Counts) rem 2 =:= 0 of
                true -> ok;
                false -> false
            end;
        false -> ok
    end,

    lists:all(fun(Rem) ->
                      case Rem of
                          0 -> true;
                          _ ->
                              Complement = (K - Rem) rem K,
                              case maps:is_key(Rem, Counts) andalso maps:is_key(Complement, Counts) of
                                  true ->
                                      maps:get(Rem, Counts) =:= maps:get(Complement, Counts);
                                  false -> false
                              end
                      end
              end, maps:keys(Counts)).