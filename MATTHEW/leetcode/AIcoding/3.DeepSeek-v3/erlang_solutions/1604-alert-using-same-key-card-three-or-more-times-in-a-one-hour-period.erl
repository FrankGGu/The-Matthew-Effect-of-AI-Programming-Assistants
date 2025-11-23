-module(solution).
-export([alert_names/1]).

alert_names(KeyCards) ->
    Dict = lists:foldl(fun([Name, Time], Acc) ->
        {H, M} = parse_time(Time),
        TotalMins = H * 60 + M,
        case dict:find(Name, Acc) of
            {ok, Times} -> dict:store(Name, [TotalMins | Times], Acc);
            error -> dict:store(Name, [TotalMins], Acc)
        end
    end, dict:new(), KeyCards),
    Names = dict:fold(fun(Name, Times, Acc) ->
        Sorted = lists:sort(Times),
        case check_alert(Sorted) of
            true -> [Name | Acc];
            false -> Acc
        end
    end, [], Dict),
    lists:sort(Names).

parse_time(Time) ->
    [H, M] = string:tokens(Time, ":"),
    {list_to_integer(H), list_to_integer(M)}.

check_alert([_, _, _ | _] = Times) ->
    check_alert(Times, 0);
check_alert(_) -> false.

check_alert([T1, T2, T3 | Rest], _) when T3 - T1 =< 60 -> true;
check_alert([_ | Rest], Count) -> check_alert(Rest, Count + 1);
check_alert(_, _) -> false.