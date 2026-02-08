-module(songs_divisible_by_60).
-export([num_pairs_divisible_by_60/1]).

num_pairs_divisible_by_60(Time) ->
    num_pairs_divisible_by_60(Time, 0, array:new(60)).

num_pairs_divisible_by_60([], Count, Counts) ->
    Count;
num_pairs_divisible_by_60([T|Rest], Count, Counts) ->
    Rem = T rem 60,
    Complement = (60 - Rem) rem 60,
    NewCount = Count + array:get(Complement, Counts),
    NewCounts = array:set(Rem, array:get(Rem, Counts) + 1, Counts),
    num_pairs_divisible_by_60(Rest, NewCount, NewCounts).