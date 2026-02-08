-module(count_alternating_subarrays).
-export([number_of_alternating_subarrays/1]).

number_of_alternating_subarrays(Nums) ->
  number_of_alternating_subarrays(Nums, 0).

number_of_alternating_subarrays([], Acc) ->
  Acc;
number_of_alternating_subarrays([_], Acc) ->
  Acc;
number_of_alternating_subarrays([A, B | Rest], Acc) ->
  number_of_alternating_subarrays([A, B | Rest], Acc, 2);

number_of_alternating_subarrays([A, B | Rest], Acc, Len) ->
  case A < B of
    true ->
      case is_alternating([A, B | Rest], Len, true) of
        true ->
          number_of_alternating_subarrays([B | Rest], Acc + 1, Len + 1);
        false ->
          number_of_alternating_subarrays([B | Rest], Acc, 2)
      end;
    false ->
      case is_alternating([A, B | Rest], Len, false) of
        true ->
          number_of_alternating_subarrays([B | Rest], Acc + 1, Len + 1);
        false ->
          number_of_alternating_subarrays([B | Rest], Acc, 2)
      end
  end.

is_alternating([_], _, _) ->
  true;
is_alternating([_, _], _, _) ->
  true;
is_alternating([A, B, C | Rest], Len, Inc) ->
  case Inc of
    true ->
      case B > C of
        true ->
          is_alternating([B, C | Rest], Len, false);
        false ->
          false
      end;
    false ->
      case B < C of
        true ->
          is_alternating([B, C | Rest], Len, true);
        false ->
          false
      end
  end;
is_alternating(_, _, _) ->
  true.