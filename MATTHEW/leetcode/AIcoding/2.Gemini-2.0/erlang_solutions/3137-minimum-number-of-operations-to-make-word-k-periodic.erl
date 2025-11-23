-module(k_periodic).
-export([min_operations/2]).

min_operations(Word, K) ->
  N = length(Word),
  if N rem K /= 0 ->
    N
  else
    M = N div K,
    Len = K,
    lists:sum([
      (Len - max_freq(sublist(Word, I, Len)))
      || I <- lists:seq(1, N, Len)
    ])
  end.

sublist(List, Start, Len) ->
  lists:sublist(List, Start, Len).

max_freq(List) ->
  Freqs = lists:foldl(
    fun(X, Acc) ->
      case maps:is_key(X, Acc) of
        true -> maps:update(X, maps:get(X, Acc) + 1, Acc);
        false -> maps:put(X, 1, Acc)
      end
    end,
    maps:new(),
    List
  ),
  max_freq_helper(maps:values(Freqs), 0).

max_freq_helper([], Max) ->
  Max;
max_freq_helper([H|T], Max) ->
  if H > Max ->
    max_freq_helper(T, H);
  true ->
    max_freq_helper(T, Max)
  end.