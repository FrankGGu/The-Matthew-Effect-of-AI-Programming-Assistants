-module(solution).
-export([largest_palindrome_product/1]).

largest_palindrome_product(N) ->
    Max = round(math:pow(10, N)) - 1,
    Min = round(math:pow(10, N - 1)),
    find_largest_palindrome(Max, Min, -1).

find_largest_palindrome(Max, Min, CurrentMax) ->
    if
        Max < Min -> CurrentMax rem 1337;
        true ->
            Product = Max * Max,
            if
                Product =< CurrentMax -> CurrentMax rem 1337;
                true ->
                    case is_palindrome(Product) of
                        true -> find_largest_palindrome(Max - 1, Min, Product);
                        false -> find_largest_palindrome(Max - 1, Min, CurrentMax)
                    end
            end
    end.

is_palindrome(N) ->
    S = integer_to_list(N),
    S == lists:reverse(S).