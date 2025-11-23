-module(minimum_valid_strings).
-export([min_number_of_valid_strings/2]).

min_number_of_valid_strings(Strings, Target) ->
    ValidCount = lists:map(fun(S) -> string_to_list(S) end, Strings),
    TargetList = string_to_list(Target),
    min_count(ValidCount, TargetList).

min_count(ValidCount, TargetList) ->
    {Ok, Count} = lists:foldl(fun(X, Acc) -> 
        case can_form(X, TargetList) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, ValidCount),
    Count.

can_form(String, Target) ->
    lists:all(fun(C) -> lists:member(C, String) end, Target).