-module(last_substring).
-export([last_substring/1]).

last_substring(S) ->
  last_substring_helper(S, 0, 1, length(S)).

last_substring_helper(S, I, J, Len) ->
  if
    J >= Len ->
      string:substr(S, I + 1);
    string:substr(S, I + 1, 1) > string:substr(S, J + 1, 1) ->
      last_substring_helper(S, I, J + 1, Len);
    string:substr(S, I + 1, 1) < string:substr(S, J + 1, 1) ->
      last_substring_helper(S, J, J + 1, Len);
    true ->
      K = 1,
      case compare_substrings(S, I, J, K, Len) of
        greater ->
          last_substring_helper(S, I, J + 1, Len);
        less ->
          last_substring_helper(S, J, J + 1, Len);
        equal ->
          last_substring_helper(S, I, J + 1, Len)
      end
  end.

compare_substrings(S, I, J, K, Len) ->
  I_K = I + K,
  J_K = J + K,
  if
    I_K >= Len ->
      less;
    J_K >= Len ->
      greater;
    string:substr(S, I_K + 1, 1) > string:substr(S, J_K + 1, 1) ->
      greater;
    string:substr(S, I_K + 1, 1) < string:substr(S, J_K + 1, 1) ->
      less;
    true ->
      compare_substrings(S, I, J, K + 1, Len)
  end.