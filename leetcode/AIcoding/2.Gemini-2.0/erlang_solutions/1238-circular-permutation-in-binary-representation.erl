-module(circular_permutation).
-export([circular_permutation/2]).

circular_permutation(N, Start) ->
  P = lists:seq(0, 1 bsl N - 1),
  lists:map(fun(X) -> bitwise:bxor(X, X bsr 1) end, lists:drop(lists:index(lists:map(fun(X) -> bitwise:bxor(X, X bsr 1) end, P),Start), lists:map(fun(X) -> bitwise:bxor(X, X bsr 1) end, P)) ++ lists:sublist(lists:map(fun(X) -> bitwise:bxor(X, X bsr 1) end, P),1,lists:index(lists:map(fun(X) -> bitwise:bxor(X, X bsr 1) end, P),Start)-1)).