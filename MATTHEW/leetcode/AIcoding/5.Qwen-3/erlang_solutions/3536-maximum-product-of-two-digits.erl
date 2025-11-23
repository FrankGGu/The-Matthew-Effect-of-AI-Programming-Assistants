-module(maximum_product_of_two_digits).
-export([maxProduct/1]).

maxProduct(Digits) ->
    lists:foldl(fun(Num, {Max1, Max2}) ->
        case Num > Max1 of
            true -> {Num, Max1};
            false -> 
                case Num > Max2 of
                    true -> {Max1, Num};
                    false -> {Max1, Max2}
                end
        end
    end, {0, 0}, Digits),
    [Max1, Max2] = lists:reverse(lists:sort(lists:usort(Digits))),
    (Max1 - 1) * (Max2 - 1).