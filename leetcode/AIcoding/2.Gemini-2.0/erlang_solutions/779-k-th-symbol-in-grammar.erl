-module(kth_grammar).
-export([kth_grammar/2]).

kth_grammar(N, K) ->
  kth_grammar_helper(N, K, 0).

kth_grammar_helper(1, 1, Val) ->
  Val;
kth_grammar_helper(N, K, Val) ->
  Half = erlang:trunc(math:pow(2, N - 2)),
  if
    K > Half ->
      kth_grammar_helper(N - 1, K - Half, 1 - Val);
    true ->
      kth_grammar_helper(N - 1, K, Val)
  end.