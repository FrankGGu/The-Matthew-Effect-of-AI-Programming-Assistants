-module(product_of_last_k_numbers).
-export([new/0, add/2, get_product/3]).

new() ->
  {ok, []}.

add({ok, List}, Num) ->
  case Num =:= 0 of
    true ->
      {ok, [0]};
    false ->
      case List of
        [] ->
          {ok, [Num]};
        [H|_] ->
          {ok, [Num * H | List]}
      end
  end.

get_product({ok, List}, K) ->
  case K > length(List) of
    true ->
      0;
    false ->
      case lists:nth(K, lists:reverse(List)) of
        0 -> 0;
        Val -> Val
      end
  end.