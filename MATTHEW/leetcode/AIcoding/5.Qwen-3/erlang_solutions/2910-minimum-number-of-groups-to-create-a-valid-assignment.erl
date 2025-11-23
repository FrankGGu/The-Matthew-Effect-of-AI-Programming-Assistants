-module(solution).
-export([min_groups/1]).

min_groups(Counts) ->
    min_groups(Counts, 1, lists:max(Counts)).

min_groups(_, Min, Max) when Min > Max ->
    Max;
min_groups(Counts, Min, Max) ->
    case is_valid(Counts, Min) of
        true ->
            Min;
        false ->
            min_groups(Counts, Min + 1, Max)
    end.

is_valid([], _) ->
    true;
is_valid([C | Cs], K) ->
    if
        C >= K ->
            is_valid(Cs, K);
        true ->
            false
    end.