-module(solution).
-export([read_binary_watch/1]).

-spec read_binary_watch(integer()) -> [unicode:unicode_binary()].
read_binary_watch(TurnedOn) ->
    %% List all possible hour and minute combinations
    HourList = lists:seq(0, 11),
    MinuteList = lists:seq(0, 59),
    
    %% Generate all possible times
    Times = lists:flatmap(fun(Hour) ->
                                lists:map(fun(Minute) ->
                                              generate_time(Hour, Minute)
                                          end, MinuteList)
                           end, HourList),

    %% Filter out times with the exact number of turned-on LEDs
    lists:filter(fun(Time) -> count_ones(Time) =:= TurnedOn end, Times).

%% Helper function to generate time string
generate_time(Hour, Minute) ->
    %% Format hour and minute, ensuring minute is always two digits
    io_lib:format("~p:~2.2p", [Hour, Minute]).

%% Count the number of 1s in the binary representation of the time
count_ones(Time) ->
    lists:sum(
        lists:map(fun(X) -> if X == $1 -> 1; true -> 0 end end, list_to_binary(Time))
    ).
