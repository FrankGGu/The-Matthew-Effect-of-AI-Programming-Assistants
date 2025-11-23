-module(longest_uncommon_subsequence_i).
-export([findLUSlength/2]).

findLUSlength(A, B) ->
  if A == B then
    -1
  else
    max(length(A), length(B))
  end.