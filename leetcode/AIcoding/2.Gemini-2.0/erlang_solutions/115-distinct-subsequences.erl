-module(distinct_subsequences).
-export([num_distinct/2]).

num_distinct(S, T) ->
  num_distinct(list_to_binary(S), list_to_binary(T)).

num_distinct(S, T) ->
  S_len = binary:longest_common_prefix(S, S),
  T_len = binary:longest_common_prefix(T, T),
  DP = array:new([S_len + 1, T_len + 1], {default, 0}),
  array:set(0, 0, 1, DP),

  num_distinct_helper(S, T, S_len, T_len, DP).

num_distinct_helper(S, T, S_len, T_len, DP) ->
  lists:foldl(fun (I, Acc) ->
                  lists:foldl(fun (J, InnerAcc) ->
                                  if
                                    I == 0 ->
                                      array:set(I, J, 0, InnerAcc);
                                    J == 0 ->
                                      array:set(I, J, 1, InnerAcc);
                                    true ->
                                      case binary:part(S, I - 1, 1) == binary:part(T, J - 1, 1) of
                                        true ->
                                          Val1 = array:get(I - 1, J - 1, InnerAcc),
                                          Val2 = array:get(I - 1, J, InnerAcc),
                                          array:set(I, J, Val1 + Val2, InnerAcc);
                                        false ->
                                          Val = array:get(I - 1, J, InnerAcc),
                                          array:set(I, J, Val, InnerAcc)
                                      end
                                  end
                                end, Acc, lists:seq(0, T_len))
                end, DP, lists:seq(0, S_len)),
  array:get(S_len, T_len, DP).