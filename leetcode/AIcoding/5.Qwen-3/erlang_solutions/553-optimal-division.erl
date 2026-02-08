-module(optimal_division).
-export([optimal_division/1]).

optimal_division(Numbers) ->
    case length(Numbers) of
        1 -> integer_to_list(hd(Numbers));
        2 -> [integer_to_list(hd(Numbers)), "/", integer_to_list(tl(Numbers))];
        _ ->
            [hd(Numbers)] ++ ["/" | lists:map(fun integer_to_list/1, tl(Numbers))]
    end.