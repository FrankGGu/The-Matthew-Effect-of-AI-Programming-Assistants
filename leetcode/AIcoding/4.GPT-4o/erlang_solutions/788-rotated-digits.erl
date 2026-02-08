-module(solution).
-export([rotatedDigits/1]).

rotatedDigits(N) ->
    lists:sum(lists:map(fun(X) -> if
        is_rotated(X) -> 1;
        true -> 0
    end end, lists:seq(1, N))).

is_rotated(X) ->
    case lists:foldl(fun(D, Acc) -> 
        case D of
            3 -> false;
            4 -> false;
            7 -> false;
            _ -> Acc
        end 
    end, true, integer_to_list(X)) of
        false -> false;
        true -> lists:foldl(fun(D, Acc) -> 
            case D of
                0 -> Acc orelse true;
                1 -> Acc orelse true;
                2 -> Acc orelse true;
                5 -> Acc orelse true;
                6 -> Acc orelse true;
                8 -> Acc orelse true;
                9 -> Acc orelse true;
                _ -> Acc
            end 
        end, false, integer_to_list(X)
    end.