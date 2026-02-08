-module(sum_of_left_leaves).
-export([sum_of_left_leaves/1]).

sum_of_left_leaves(Root) ->
  sum_of_left_leaves(Root, false).

sum_of_left_leaves(nil, _) ->
  0;
sum_of_left_leaves({Val, L, R}, IsLeft) ->
  (case
     IsLeft andalso L == nil andalso R == nil ->
       Val;
     true ->
       0
   end) +
  sum_of_left_leaves(L, true) +
  sum_of_left_leaves(R, false).