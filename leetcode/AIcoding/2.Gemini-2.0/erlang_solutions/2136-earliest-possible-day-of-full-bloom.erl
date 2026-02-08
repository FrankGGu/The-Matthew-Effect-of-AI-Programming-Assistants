-module(earliest_bloom).
-export([earliest_full_bloom/2]).

earliest_full_bloom(plant_time, grow_time) ->
    N = length(plant_time),
    Flowers = lists:zip(plant_time, grow_time),
    SortedFlowers = lists:keysort(2, lists:zip(lists:seq(1, N), Flowers)),
    earliest_full_bloom_helper(SortedFlowers, 0, 0).

earliest_full_bloom_helper([], CurrentTime, MaxBloom) ->
    MaxBloom;
earliest_full_bloom_helper([ {_, {Plant, Grow} } | Rest], CurrentTime, MaxBloom) ->
    NewTime = CurrentTime + Plant,
    BloomTime = NewTime + Grow,
    NewMax = max(MaxBloom, BloomTime),
    earliest_full_bloom_helper(Rest, NewTime, NewMax).