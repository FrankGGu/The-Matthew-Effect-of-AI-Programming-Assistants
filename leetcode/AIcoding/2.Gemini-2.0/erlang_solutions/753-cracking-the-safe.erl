-module(cracking_the_safe).
-export([crack_safe/2]).

crack_safe(N, K) ->
  Len = erlang:trunc(math:pow(K, N)) + N - 1,
  crack_safe_helper(N, K, Len, "", sets:new(), []).

crack_safe_helper(N, K, Len, Current, Seen, Acc) ->
  if
    length(Acc) == Len ->
      lists:reverse(Acc);
    true ->
      Prefix = lists:sublist(Current, max(0, length(Current) - N + 1)),
      NextDigitFun = fun(Digit) ->
          NewPrefix = Prefix ++ integer_to_list(Digit),
          case sets:is_element(list_to_integer(NewPrefix), Seen) of
            true -> false;
            false ->
              NewSeen = sets:add_element(list_to_integer(NewPrefix), Seen),
              NewCurrent = Current ++ integer_to_list(Digit),
              crack_safe_helper(N, K, Len, NewCurrent, NewSeen, Acc ++ [Digit])
          end
      end,
      Digits = lists:seq(K - 1, 0, -1),
      case lists:any(NextDigitFun, Digits) of
        true ->
          lists:reverse(Acc);
        false ->
          lists:reverse(Acc)
      end
  end.