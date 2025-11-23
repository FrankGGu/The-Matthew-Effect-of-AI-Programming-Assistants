-module(solution).
-export([maximumGroups/1]).

maximumGroups(UsageLimits) ->
    SortedUsageLimits = lists:sort(UsageLimits),
    MaxPossibleK = calculate_max_k_upper_bound(SortedUsageLimits),
    binary_search(0, MaxPossibleK, SortedUsageLimits, 0).

calculate_max_k_upper_bound(SortedUsageLimits) ->
    TotalSum = lists:sum(SortedUsageLimits),
    % k * (k + 1) / 2 <= TotalSum
    % k^2 approx 2 * TotalSum
    % k approx sqrt(2 * TotalSum)
    % Add a small buffer for safety
    trunc(math:sqrt(2 * TotalSum)) + 2.

binary_search(Low, High, SortedUsageLimits, Ans) when Low =< High ->
    Mid = Low + (High - Low) div 2,
    case Mid of
        0 -> % Always possible to form 0 groups
            binary_search(Mid + 1, High, SortedUsageLimits, erlang:max(Ans, Mid));
        _ ->
            case check(Mid, SortedUsageLimits) of
                true ->
                    binary_search(Mid + 1, High, SortedUsageLimits, erlang:max(Ans, Mid));
                false ->
                    binary_search(Low, Mid - 1, SortedUsageLimits, Ans)
            end
    end;
binary_search(_Low, _High, _SortedUsageLimits, Ans) ->
    Ans.

check(K, SortedUsageLimits) ->
    check_loop(K, SortedUsageLimits, 0, 0).

check_loop(K, [Limit | Rest], CurrentItemsAvailable, GroupsPossible) ->
    NewCurrentItemsAvailable = CurrentItemsAvailable + Limit,
    RequiredForNextGroup = (GroupsPossible + 1) * (GroupsPossible + 2) div 2,
    case NewCurrentItemsAvailable >= RequiredForNextGroup of
        true ->
            check_loop(K, Rest, NewCurrentItemsAvailable, GroupsPossible + 1);
        false ->
            check_loop(K, Rest, NewCurrentItemsAvailable, GroupsPossible)
    end;
check_loop(K, [], _CurrentItemsAvailable, GroupsPossible) ->
    GroupsPossible >= K.