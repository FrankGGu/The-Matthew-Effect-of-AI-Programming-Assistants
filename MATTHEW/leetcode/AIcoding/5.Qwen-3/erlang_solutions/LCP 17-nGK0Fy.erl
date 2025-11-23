-module(leetcode_1276).
-export([num_of_ways/1]).

num_of_ways(N) ->
    num_of_ways(N, 0, 1).

num_of_ways(N, Acc, I) when I > N ->
    Acc;
num_of_ways(N, Acc, I) ->
    case (I rem 3 == 0) andalso (I rem 5 == 0) of
        true -> num_of_ways(N, Acc + 1, I + 1);
        false -> num_of_ways(N, Acc, I + 1)
    end.