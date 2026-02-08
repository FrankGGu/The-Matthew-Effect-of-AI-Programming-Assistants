-module(solution).
-export([busiest_servers/3]).

busiest_servers(K, Arrival, Load) ->
    Servers = lists:seq(0, K - 1),
    Available = gb_sets:from_list(Servers),
    Busy = gb_trees:empty(),
    Counts = lists:duplicate(K, 0),
    {_, _, FinalCounts} = lists:foldl(fun process_request/2, {Available, Busy, Counts}, lists:zip(Arrival, Load)),
    Max = lists:max(FinalCounts),
    [I || {I, C} <- lists:zip(lists:seq(0, K - 1), FinalCounts), C =:= Max].

process_request({ArrivalTime, LoadTime}, {Available, Busy, Counts}) ->
    {NewAvailable, NewBusy} = update_busy_servers(ArrivalTime, Available, Busy),
    case gb_sets:is_empty(NewAvailable) of
        true ->
            {NewAvailable, NewBusy, Counts};
        false ->
            Server = find_server(ArrivalTime, NewAvailable),
            NewCounts = update_counts(Server, Counts),
            EndTime = ArrivalTime + LoadTime,
            {gb_sets:del_element(Server, NewAvailable), gb_trees:enter(EndTime, Server, NewBusy), NewCounts}
    end.

update_busy_servers(Time, Available, Busy) ->
    case gb_trees:is_empty(Busy) of
        true ->
            {Available, Busy};
        false ->
            {MinKey, MinVal, NewBusy} = gb_trees:take_smallest(Busy),
            if
                MinKey =< Time ->
                    NewAvailable = gb_sets:add_element(MinVal, Available),
                    update_busy_servers(Time, NewAvailable, NewBusy);
                true ->
                    {Available, gb_trees:enter(MinKey, MinVal, NewBusy)}
            end
    end.

find_server(ArrivalTime, Available) ->
    case gb_sets:is_empty(Available) of
        true -> -1;
        false ->
            Candidates = gb_sets:to_list(Available),
            case lists:member(ArrivalTime rem length(Candidates), Candidates) of
                true -> ArrivalTime rem length(Candidates);
                false ->
                    find_next_server(ArrivalTime rem length(Candidates), Candidates)
            end
    end.

find_next_server(Start, Candidates) ->
    Sorted = lists:sort(Candidates),
    case lists:dropwhile(fun(X) -> X =< Start end, Sorted) of
        [] -> hd(Sorted);
        [H|_] -> H
    end.

update_counts(Server, Counts) ->
    lists:sublist(Counts, Server) ++ [lists:nth(Server + 1, Counts) + 1] ++ lists:nthtail(Server + 1, Counts).