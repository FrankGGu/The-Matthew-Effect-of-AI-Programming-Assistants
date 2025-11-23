-module(solution).
-export([minimum_index/1]).

minimum_index(List) ->
    N = length(List),
    {Prefix, Suffix} = lists:split(N div 2, List),
    PrefixMax = lists:max(Prefix),
    SuffixMin = lists:min(Suffix),
    if
        PrefixMax < SuffixMin ->
            lists:prefix_length(Prefix) - 1;
        true ->
            -1
    end.