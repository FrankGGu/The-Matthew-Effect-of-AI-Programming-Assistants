-module(count_substrings_i).
-export([count_substrings/2]).

count_substrings(S, T) ->
  N = length(S),
  K = length(T),
  count_substrings_helper(S, T, N, K).

count_substrings_helper(S, T, N, K) ->
  lists:sum([
    case can_rearrange_to_contain(lists:sublist(S, I, J - I + 1), T) of
      true -> 1;
      false -> 0
    end
    || I <- lists:seq(1, N), J <- lists:seq(I, N)
  ]).

can_rearrange_to_contain(Substr, T) ->
  SubstrCount = char_counts(Substr),
  TCount = char_counts(T),
  lists:all(fun(Char) ->
    case maps:get(Char, TCount, 0) =< maps:get(Char, SubstrCount, 0) of
      true -> true;
      false -> false
    end
  end, maps:keys(TCount)).

char_counts(Str) ->
  lists:foldl(fun(Char, Acc) ->
    maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
  end, #{}, Str).