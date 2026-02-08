-module(poor_pigs).
-export([poor_pigs/3]).

poor_pigs(Buckets, MinutesToDie, MinutesToTest) ->
    if Buckets =:= 1 ->
        0;
    true ->
        States := MinutesToTest div MinutesToDie + 1,
        ceil(math:log(Buckets) / math:log(States))
    end.