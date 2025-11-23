-module(jewels_and_stones).
-export([num_jewels_in_stones/2]).

num_jewels_in_stones(Jewels, Stones) ->
    num_jewels_in_stones(Jewels, Stones, 0).

num_jewels_in_stones([], _, Count) ->
    Count;
num_jewels_in_stones([H|T], Stones, Count) ->
    NewCount = Count + count_occurrences(H, Stones),
    num_jewels_in_stones(T, Stones, NewCount).

count_occurrences(_, []) ->
    0;
count_occurrences(Jewel, [Stone | Rest]) ->
    case Jewel =:= Stone of
        true ->
            1 + count_occurrences(Jewel, Rest);
        false ->
            count_occurrences(Jewel, Rest)
    end.