-module(count_collisions_on_a_road).
-export([count_collisions/1]).

count_collisions(Road) ->
    count_collisions(Road, 0, []).

count_collisions([], _Count, Acc) ->
    lists:sum(Acc);
count_collisions([$R | Rest], Count, Acc) ->
    count_collisions(Rest, Count + 1, Acc);
count_collisions([$L | Rest], Count, Acc) ->
    count_collisions(Rest, Count, [Count | Acc]);
count_collisions([$S | Rest], Count, Acc) ->
    count_collisions(Rest, Count, [Count | Acc]).