-module(solution).
-export([high_access_employees/1]).

high_access_employees(AccessTimes) ->
    GroupedAccess = lists:foldl(
        fun([Name, TimeStr], Acc) ->
            Minutes = parse_time(TimeStr),
            maps:update_with(Name, fun(Times) -> [Minutes | Times] end, [Minutes], Acc)
        end,
        maps:new(),
        AccessTimes
    ),

    HighAccessEmployees = lists:foldl(
        fun({Name, Times}, Acc) ->
            SortedTimes = lists:sort(Times),
            case check_high_access(SortedTimes) of
                true -> [Name | Acc];
                false -> Acc
            end
        end,
        [],
        maps:to_list(GroupedAccess)
    ),

    lists:sort(HighAccessEmployees).

parse_time(TimeStr) ->
    [H_str, M_str] = string:tokens(TimeStr, ":"),
    list_to_integer(H_str) * 60 + list_to_integer(M_str).

check_high_access(SortedTimes) ->
    check_high_access_recursive(SortedTimes).

check_high_access_recursive([T1, _T2, T3 | Rest]) ->
    if
        T3 - T1 =< 59 -> true;
        true -> check_high_access_recursive(tl([_T2, T3 | Rest]))
    end;
check_high_access_recursive(_) ->
    false.