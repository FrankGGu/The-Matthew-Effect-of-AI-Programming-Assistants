-module(solution).
-export([min_length/2]).

min_length(S1, S2) ->
    S1Map = maps:from_list(string:to_list(S1)),
    S2Map = maps:from_list(string:to_list(S2)),
    AnagramMap = maps:merge(fun(_, V1, V2) -> V1 + V2 end, S1Map, S2Map),
    lists:sum(maps:to_list(AnagramMap)).