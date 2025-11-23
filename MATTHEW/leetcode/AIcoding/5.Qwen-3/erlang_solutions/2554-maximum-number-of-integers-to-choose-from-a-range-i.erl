-module(solution).
-export([max_number/2]).

max_number(Range, Forbidden) ->
    Max = lists:max(Range),
    Min = lists:min(Range),
    ForbiddenSet = sets:from_list(Forbidden),
    Count = 0,
    max_number_helper(Min, Max, ForbiddenSet, Count).

max_number_helper(Num, Max, _, Count) when Num > Max ->
    Count;
max_number_helper(Num, Max, ForbiddenSet, Count) ->
    case sets:is_element(Num, ForbiddenSet) of
        true ->
            max_number_helper(Num + 1, Max, ForbiddenSet, Count);
        false ->
            max_number_helper(Num + 1, Max, ForbiddenSet, Count + 1)
    end.