-module(k_divisible_elements_subarrays).
-export([k_divisible_elements_subarrays/2]).

k_divisible_elements_subarrays(Nums, P) ->
  k_divisible_elements_subarrays(Nums, P, []).

k_divisible_elements_subarrays([], _, Acc) ->
  length(lists:usort(Acc));
k_divisible_elements_subarrays(Nums, P, Acc) ->
  k_divisible_elements_subarrays(Nums, P, 0, Acc, []).

k_divisible_elements_subarrays([H|T], P, K, Acc, Sub) ->
  case H rem P =:= 0 of
    true ->
      case K < 201 of
        true ->
          NewK = K + 1,
          NewSub = Sub ++ [H],
          NewAcc = Acc ++ [NewSub],
          k_divisible_elements_subarrays(T, P, NewK, NewAcc, NewSub);
        false ->
          NewSub = Sub ++ [H],
          NewAcc = Acc ++ [NewSub],
          length(lists:usort(NewAcc))
      end;
    false ->
      NewSub = Sub ++ [H],
      NewAcc = Acc ++ [NewSub],
      k_divisible_elements_subarrays(T, P, K, NewAcc, NewSub)
  end;
k_divisible_elements_subarrays([], _, _, Acc, _) ->
  length(lists:usort(Acc)).