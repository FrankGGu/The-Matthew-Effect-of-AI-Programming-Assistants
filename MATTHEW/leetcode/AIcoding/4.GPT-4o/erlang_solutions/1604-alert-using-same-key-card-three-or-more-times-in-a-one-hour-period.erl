-module(solution).
-export([alert_using_same_keycard/1]).

alert_using_same_keycard/1 ->
    %% Sample input: [["Alice","12:00"],["Alice","12:01"],["Alice","12:02"],["Alice","12:03"],["Bob","12:00"]]
    Data = get_data(),
    Grouped = lists:foldl(fun({Name, Time}, Acc) ->
        TimeInMinutes = time_to_minutes(Time),
        maps:update_with(Name, fun(X) -> [TimeInMinutes | X] end, [TimeInMinutes], Acc)
    end, #{}, Data),
    lists:filter(fun({_, Times}) -> check_alert(Times) end, maps:to_list(Grouped)).

time_to_minutes(Time) ->
    [Hour, Minute] = string:tokens(Time, ":"),
    list_to_integer(Hour) * 60 + list_to_integer(Minute).

check_alert(Times) ->
    SortedTimes = lists:sort(Times),
    lists:foldl(fun(Time, {Prev, Count}) ->
        if
            Count >= 3 -> {Prev, Count};
            Prev >= Time - 60 -> {Time, Count + 1};
            true -> {Time, 1}
        end
    end, {0, 0}, SortedTimes) =:= {0, 1}.

get_data() ->
    [["Alice","12:00"],["Alice","12:01"],["Alice","12:02"],["Alice","12:03"],["Bob","12:00"]].