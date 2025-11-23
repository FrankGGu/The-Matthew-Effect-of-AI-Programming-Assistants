-module(solution).
-export([largest_palindrome/1]).

-spec largest_palindrome(integer()) -> integer().
largest_palindrome(N) ->
    MaxNum = math:pow(10, N) - 1,
    MinNum = math:pow(10, N - 1),
    largest_palindrome(MaxNum, MinNum, MaxNum).

largest_palindrome(MaxNum, MinNum, Factor) ->
    case Factor >= MinNum of
        true -> 
            case find_palindrome(MaxNum, Factor) of
                {ok, Palindrome} -> Palindrome rem 1337;
                error -> largest_palindrome(MaxNum, MinNum, Factor - 1)
            end;
        false -> 0
    end.

find_palindrome(MaxNum, Factor) ->
    Product = Factor * MaxNum,
    Palindrome = is_palindrome(Product),
    case Palindrome of
        true -> {ok, Product};
        false -> error
    end.

is_palindrome(Product) ->
    ProductStr = integer_to_list(Product),
    ProductStr == lists:reverse(ProductStr).
