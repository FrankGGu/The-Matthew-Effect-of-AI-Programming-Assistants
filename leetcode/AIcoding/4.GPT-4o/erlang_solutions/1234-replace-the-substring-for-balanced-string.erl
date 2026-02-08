-module(solution).
-export([balanced_string_soup/1]).

balanced_string_soup(S) ->
    Count = length(S),
    Needed = Count div 4,
    Frequencies = frequency(S),
    MinLength = min_length(Frequencies, Needed, Count),
    MinLength.

frequency(S) ->
    lists:foldl(fun(Char, Acc) -> 
        case lists:keyfind(Char, 1, Acc) of
            false -> [{Char, 1} | Acc];
            {Char, Count} -> [{Char, Count + 1} | lists:keydelete(Char, 1, Acc)]
        end
    end, [], S).

min_length(Frequencies, Needed, Count) ->
    case lists:foldl(fun({Char, Count}, Acc) -> 
            case Count - Needed of
                X when X > 0 -> Acc + X;
                _ -> Acc
            end
        end, 0, Frequencies) of
        0 -> 0;
        _ -> 
            Min = lists:foldl(fun({Char, Count}, Acc) -> 
                case Count - Needed of
                    X when X > 0 -> min(Acc, X);
                    _ -> Acc
                end
            end, Count, Frequencies),
            Min
    end.