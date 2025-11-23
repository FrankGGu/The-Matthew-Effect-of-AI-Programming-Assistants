-module(solution).
-export([maximum_total_beauty/2]).

maximum_total_beauty(N, gardens) ->
    lists:foldl(fun(Garden, {TotalBeauty, MaxBeauty}) ->
        case Garden of
            {Beauty, 0} -> {TotalBeauty + Beauty, MaxBeauty};
            {Beauty, _} -> {TotalBeauty + min(Beauty, MaxBeauty), max(MaxBeauty, Beauty)}
        end
    end, {0, 0}, gardens).