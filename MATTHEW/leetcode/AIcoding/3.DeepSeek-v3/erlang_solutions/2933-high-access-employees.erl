-module(solution).
-export([high_access_employees/1]).

high_access_employees(Access_times) ->
    Dict = lists:foldl(fun([Name, Time], Acc) ->
        TimeInt = list_to_integer(Time),
        case dict:find(Name, Acc) of
            {ok, Times} -> dict:store(Name, [TimeInt | Times], Acc);
            error -> dict:store(Name, [TimeInt], Acc)
        end
    end, dict:new(), Access_times),
    Filtered = dict:fold(fun(Name, Times, Acc) ->
        Sorted = lists:sort(Times),
        case has_high_access(Sorted) of
            true -> [Name | Acc];
            false -> Acc
        end
    end, [], Dict),
    lists:sort(Filtered).

has_high_access([A, B, C | Rest]) ->
    if
        C - A < 100 -> true;
        true -> has_high_access([B, C | Rest])
    end;
has_high_access(_) -> false.