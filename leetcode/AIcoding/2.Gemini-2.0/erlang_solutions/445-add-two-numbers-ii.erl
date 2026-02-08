-module(add_two_numbers_ii).
-export([add_two_numbers/2]).

-spec add_two_numbers(List1 :: [integer()], List2 :: [integer()]) -> [integer()].
add_two_numbers(L1, L2) ->
    Num1 = list_to_integer(lists:reverse(L1)),
    Num2 = list_to_integer(lists:reverse(L2)),
    Sum = Num1 + Num2,
    digits(Sum).

digits(0) -> [0];
digits(N) ->
    digits_helper(N, []).

digits_helper(0, Acc) ->
    lists:reverse(Acc);
digits_helper(N, Acc) ->
    digits_helper(N div 10, [N rem 10 | Acc]).