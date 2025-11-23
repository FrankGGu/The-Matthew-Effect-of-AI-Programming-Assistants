-module(solution).
-export([beautiful_subsets/2]).

beautiful_subsets(List, K) ->
    {Count, _} = beautiful_subsets(List, K, 0),
    Count.

beautiful_subsets([], _K, Count) ->
    {Count + 1, Count}; % count the empty subset
beautiful_subsets([H | T], K, Count) ->
    {CountWithH, _} = beautiful_subsets(T, K, Count),
    {CountWithoutH, _} = beautiful_subsets(T, K, Count),
    if
        H rem K =:= 0 ->
            {CountWithH + CountWithoutH, Count};
        true ->
            {CountWithH + CountWithoutH, Count}
    end.