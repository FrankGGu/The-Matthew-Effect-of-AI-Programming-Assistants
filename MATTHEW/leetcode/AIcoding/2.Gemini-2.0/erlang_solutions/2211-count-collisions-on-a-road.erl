-module(count_collisions).
-export([count_collisions/1]).

count_collisions(Directions) ->
  count_collisions_helper(Directions, 0).

count_collisions_helper([], Acc) ->
  Acc;
count_collisions_helper([H|T], Acc) ->
  count_collisions_helper(T, count_collisions_step(H, T, Acc)).

count_collisions_step(115, [108|Rest], Acc) ->
  count_collisions_helper(Rest, Acc+2);
count_collisions_step(115, [114|Rest], Acc) ->
  count_collisions_helper(Rest, Acc+1);
count_collisions_step(115, [115|Rest], Acc) ->
  count_collisions_helper(Rest, Acc+1);
count_collisions_step(108, [114|Rest], Acc) ->
  count_collisions_helper(Rest, Acc+2);
count_collisions_step(108, [115|Rest], Acc) ->
  count_collisions_helper(Rest, Acc+1);
count_collisions_step(114, [114|Rest], Acc) ->
  count_collisions_helper(Rest, Acc);
count_collisions_step(114, [115|Rest], Acc) ->
  count_collisions_helper(Rest, Acc);
count_collisions_step(H, T, Acc) ->
  count_collisions_helper(T, Acc).