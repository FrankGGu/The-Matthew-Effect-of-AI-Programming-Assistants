-module(solution).
-export([maximum_number_of_string_pairs/1]).

maximum_number_of_string_pairs(Strings) ->
    Pairs = lists:foldl(fun(Str, Acc) -> 
        case lists:keyfind(Str, 1, Acc) of 
            false -> [{Str, lists:reverse(Str)} | Acc]; 
            _ -> Acc 
        end 
    end, [], Strings),
    length(Pairs) div 2.