-module(solution).
-export([smallest_palindromic_rearrangement/1]).

smallest_palindromic_rearrangement(S) ->
    Counts = lists:foldl(fun(C, Acc) -> 
        case maps:find(C, Acc) of
            {ok, Count} -> maps:put(C, Count + 1, Acc);
            _ -> maps:put(C, 1, Acc)
        end
    end, map:new(), string:to_list(S)),

    OddCount = lists:filter(fun({_, C}) -> C rem 2 =:= 1 end, maps:to_list(Counts)),
    if 
        length(OddCount) > 1 -> 
            ""
        ;
        true -> 
            Half = lists:foldl(fun({C, Count}, Acc) -> 
                Acc ++ lists:duplicate(Count div 2, C) 
            end, [], maps:to_list(Counts)),
            Palindrome = Half ++ lists:reverse(Half),
            case OddCount of
                [] -> lists:flatten(Palindrome);
                [{C, _}] -> lists:flatten(Palindrome ++ [C] ++ lists:reverse(Palindrome))
            end
    end.