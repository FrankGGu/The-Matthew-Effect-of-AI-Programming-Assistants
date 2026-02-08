-module(distinct_subsequences).
-export([num_distinct/2]).

num_distinct(S, T) ->
  num_distinct(list_to_binary(S), list_to_binary(T)).

num_distinct(S, T) ->
  S_len = binary_size(S),
  T_len = binary_size(T),
  num_distinct(S, S_len, T, T_len).

num_distinct(S, S_len, T, T_len) ->
  case {S_len, T_len} of
    {_, 0} -> 1;
    {0, _} -> 0;
    _ ->
      case binary:at(S, S_len - 1) of
        binary:at(T, T_len - 1) ->
          num_distinct(S, S_len - 1, T, T_len - 1) + num_distinct(S, S_len - 1, T, T_len);
        _ ->
          num_distinct(S, S_len - 1, T, T_len)
      end
  end.