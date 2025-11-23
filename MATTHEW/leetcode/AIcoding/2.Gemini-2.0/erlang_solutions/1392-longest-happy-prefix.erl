-module(longest_happy_prefix).
-export([longest_prefix/1]).

longest_prefix(S) ->
  N = length(S),
  Prefix = string:substr(S, 1, N - 1),
  Suffix = string:substr(S, 2, N - 1),
  longest_happy_prefix_helper(Prefix, Suffix, N - 1, S).

longest_happy_prefix_helper(Prefix, Suffix, Len, S) when Len > 0 ->
  case Prefix =:= string:substr(S, length(S) - Len + 1, Len) of
    true ->
      string:substr(S, 1, Len);
    false ->
      Prefix_new = string:substr(Prefix, 1, Len - 1),
      Suffix_new = string:substr(S, 2, Len - 1),
      longest_happy_prefix_helper(Prefix_new, Suffix_new, Len - 1, S)
  end;
longest_happy_prefix_helper(_, _, 0, _) ->
  "".