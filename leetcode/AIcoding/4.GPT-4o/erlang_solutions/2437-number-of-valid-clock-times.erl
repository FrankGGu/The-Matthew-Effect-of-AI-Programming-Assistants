-module(solution).
-export([number_of_valid_clock_times/1]).

number_of_valid_clock_times(Input) ->
    {H1, H2, M1, M2} = parse_input(Input),
    lists:foldl(fun(Hour, Acc) ->
        lists:foldl(fun(Minute, Acc2) ->
            case is_valid_time(Hour, Minute) of
                true -> Acc2 + 1;
                false -> Acc2
            end
        end, Acc, get_minutes(M1, M2))
    end, 0, get_hours(H1, H2)).

parse_input(Input) ->
    {list_to_integer(binary_to_list(Input, 0, 1)),
     list_to_integer(binary_to_list(Input, 1, 2)),
     list_to_integer(binary_to_list(Input, 3, 4)),
     list_to_integer(binary_to_list(Input, 4, 5))}.

get_hours(H1, H2) ->
    case {H1, H2} of
        {_, _} when H1 >= 2 -> [[H1, H2]];
        {0, _} -> [[0, H2], [1, H2]];
        {1, _} -> [[1, H2]];
        {2, _} -> [[2, H2]];
    end.

get_minutes(M1, M2) ->
    [[M1, M2]].

is_valid_time(Hour, Minute) ->
    Hour < 24 andalso Minute < 60.