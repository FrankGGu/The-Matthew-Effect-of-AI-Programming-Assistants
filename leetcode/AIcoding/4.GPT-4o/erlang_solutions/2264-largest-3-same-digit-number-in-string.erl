-module(solution).
-export([largest_3_same_digit_number/1]).

largest_3_same_digit_number(S) ->
    Digits = lists:filter(fun(C) -> C >= $0, C =< $9 end, string:to_list(S)),
    Groups = lists:foldl(fun(D, Acc) -> 
        case lists:keyfind(D, 1, Acc) of
            false -> [{D, 1} | Acc];
            {D, Count} -> [{D, Count + 1} | lists:keydelete(D, 1, Acc)]
        end
    end, [], Digits),
    Filtered = lists:filter(fun({_, Count}) -> Count >= 3 end, Groups),
    Largest = lists:max(lists:map(fun({D, _}) -> D end, Filtered)),
    case Largest of
        undefined -> "-1";
        _ -> integer_to_list(Largest * 111)
    end.