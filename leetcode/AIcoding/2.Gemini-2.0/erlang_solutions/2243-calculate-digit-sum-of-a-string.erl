-module(digit_sum).
-export([digit_sum/2]).

digit_sum(S, K) ->
  digit_sum_helper(S, K).

digit_sum_helper(S, K) ->
  Len = length(S),
  if Len =< K ->
    S
  else
    Chunks = chunk_string(S, K),
    NewS = lists:foldl(fun(Chunk, Acc) ->
                            Sum = list_to_integer(Chunk) + 0,
                            Acc ++ integer_to_list(Sum)
                        end, "", Chunks),
    digit_sum_helper(NewS, K)
  end.

chunk_string(S, K) ->
  chunk_string_helper(S, K, []).

chunk_string_helper("", _K, Acc) ->
  lists:reverse(Acc);
chunk_string_helper(S, K, Acc) ->
  {Chunk, Rest} = split_at(S, K),
  chunk_string_helper(Rest, K, [Chunk | Acc]).

split_at(S, N) ->
  split_at_helper(S, N, [], 0).

split_at_helper("", _N, Acc, _) ->
  {lists:reverse(Acc), ""};
split_at_helper(S, N, Acc, Count) ->
  [H | T] = string:to_list(S),
  if Count < N ->
    split_at_helper(list_to_string(T), N, [H | Acc], Count + 1)
  else
    {lists:reverse(Acc), S}
  end.