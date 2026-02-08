-module(max_bags_with_full_capacity_of_rocks).
-export([maximumNumberOfBags/2]).

maximumNumberOfBags(Capacity, Rocks) ->
    Sorted = lists:sort(lists:zip(Capacity, Rocks)),
    MaxBags = 0,
    lists:foldl(fun({C, R}, Acc) ->
                        if C - R >= 0 -> Acc + 1;
                           true -> Acc
                        end
                    end, MaxBags, Sorted).