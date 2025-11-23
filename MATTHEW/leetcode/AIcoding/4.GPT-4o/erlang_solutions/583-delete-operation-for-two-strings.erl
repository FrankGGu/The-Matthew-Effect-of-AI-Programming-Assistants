-module(solution).
-export([min_distance/2]).

min_distance(Str1, Str2) ->
    L1 = string:length(Str1),
    L2 = string:length(Str2),
    D = array:new({L1 + 1, L2 + 1}),
    lists:foreach(fun(I) -> array:write(D, {I, 0}, I - 1) end, lists:seq(0, L1)),
    lists:foreach(fun(J) -> array:write(D, {0, J}, J) end, lists:seq(0, L2)),
    min_distance_helper(Str1, Str2, D, L1, L2).

min_distance_helper(_, _, D, 0, L2) ->
    L2;
min_distance_helper(_, _, D, L1, 0) ->
    L1;
min_distance_helper(Str1, Str2, D, L1, L2) ->
    if
        string:nth(L1, Str1) == string:nth(L2, Str2) ->
            min_distance_helper(Str1, Str2, D, L1 - 1, L2 - 1);
        true ->
            Del1 = 1 + min_distance_helper(Str1, Str2, D, L1 - 1, L2),
            Del2 = 1 + min_distance_helper(Str1, Str2, D, L1, L2 - 1),
            Del3 = 1 + min_distance_helper(Str1, Str2, D, L1 - 1, L2 - 1),
            lists:min([Del1, Del2, Del3])
    end.