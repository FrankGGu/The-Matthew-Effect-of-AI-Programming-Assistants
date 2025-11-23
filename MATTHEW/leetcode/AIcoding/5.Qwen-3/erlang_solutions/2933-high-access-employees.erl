-module(high_access_employees).
-export([high_access_employees/1]).

high_access_employees(Records) ->
    Map = maps:new(),
    lists:foldl(fun(Record, Acc) ->
        [Name, Time] = Record,
        TimeInt = list_to_integer(Time),
        case maps:find(Name, Acc) of
            {ok, List} ->
                maps:put(Name, [TimeInt | List], Acc);
            error ->
                maps:put(Name, [TimeInt], Acc)
        end
    end, Map, Records),
    lists:filter(fun({Name, Times}) ->
        Sorted = lists:sort(Times),
        lists:all(fun(I) -> I >= 0 andalso I < 24 end, Sorted),
        Length = length(Sorted),
        if
            Length < 3 -> false;
            true ->
                lists:member(0, Sorted) andalso lists:member(23, Sorted) andalso lists:member(22, Sorted)
        end
    end, maps:to_list(Map)).

high_access_employees([]) ->
    [].