-module(solution).
-export([max_difference_by_remapping_a_digit/1]).

max_difference_by_remapping_a_digit(Num) ->
    NumStr = integer_to_list(Num),
    MaxStr = get_max_num_str(NumStr),
    MinStr = get_min_num_str(NumStr),
    MaxVal = list_to_integer(MaxStr),
    MinVal = list_to_integer(MinStr),
    MaxVal - MinVal.

get_max_num_str(NumStr) ->
    case lists:dropwhile(fun(C) -> C == $9 end, NumStr) of
        [] ->
            NumStr;
        [TargetChar|_] ->
            lists:map(fun(C) -> if C == TargetChar -> $9; true -> C end end, NumStr)
    end.

get_min_num_str(NumStr) ->
    TargetChar = hd(NumStr),
    lists:map(fun(C) -> if C == TargetChar -> $0; true -> C end end, NumStr).