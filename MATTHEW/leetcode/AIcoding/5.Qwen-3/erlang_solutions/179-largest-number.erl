-module(largest_number).
-export([largest_number/1]).

largest_number(Numbers) ->
    Sorted = lists:sort(Numbers, fun(A, B) -> 
        case lists:reverse(A) of
            [H|_] -> 
                case lists:reverse(B) of
                    [H|_] -> A > B;
                    _ -> A > B
                end;
            _ -> A > B
        end
    end),
    case lists:all(fun(N) -> N == 0 end, Sorted) of
        true -> "0";
        false -> lists:flatten([integer_to_list(N) || N <- Sorted])
    end.