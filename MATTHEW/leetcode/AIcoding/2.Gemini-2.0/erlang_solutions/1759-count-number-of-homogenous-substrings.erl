-module(solution).
-export([countHomogenous/1]).

countHomogenous(S) ->
  countHomogenous_helper(S, 0, 0, 0).

countHomogenous_helper([], _, Count, Sum) ->
  (Sum + Count * (Count + 1) div 2) rem 1000000007;
countHomogenous_helper([H|T], Last, Count, Sum) ->
  case H =:= Last of
    true ->
      countHomogenous_helper(T, H, Count + 1, Sum);
    false ->
      countHomogenous_helper(T, H, 1, (Sum + Count * (Count + 1) div 2) rem 1000000007)
  end.