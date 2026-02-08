-module(finding_3_digit_even_numbers).
-export([find_even_numbers/1]).

find_even_numbers(Digits) ->
  find_even_numbers(Digits, []).

find_even_numbers(Digits, Acc) ->
  lists:sort(lists:usort([X || X <- generate_numbers(Digits), X >= 100])).

generate_numbers(Digits) ->
  generate_numbers(Digits, []).

generate_numbers(Digits, Acc) ->
  [
    D1 * 100 + D2 * 10 + D3
    || D1 <- lists:usort(Digits),
       D2 <- lists:usort(Digits),
       D3 <- lists:usort(lists:filter(fun(D) -> D rem 2 == 0 end, Digits))
  ].