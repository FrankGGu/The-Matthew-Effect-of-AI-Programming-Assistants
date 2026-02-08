-module(abbreviate_product).
-export([abbreviate_product/2]).

abbreviate_product(Left, Right) ->
  {Product, TrailingZeros} = product_and_trailing_zeros(Left, Right, 1, 0),

  case Product of
    {ok, P} when P < 100000 ->
      io_lib:format("~w", [P]) ++ "e" ++ integer_to_list(TrailingZeros);
    {ok, P} ->
      S = integer_to_list(P),
      L = length(S),
      First5 = string:substr(S, 1, 5),
      Last5 = string:substr(S, L - 4, 5),
      First5 ++ "..." ++ Last5 ++ "e" ++ integer_to_list(TrailingZeros);
    {overflow, _} ->
      {First5, Last5} = first_and_last_5(Left, Right),
      First5 ++ "..." ++ Last5 ++ "e" ++ integer_to_list(TrailingZeros)
  end.

product_and_trailing_zeros(Left, Right, Acc, AccZeros) when Left > Right ->
  {ok, Acc, AccZeros};
product_and_trailing_zeros(Left, Right, Acc, AccZeros) ->
  case Acc > 1000000000000 of
    true ->
      {overflow, Acc, AccZeros};
    false ->
      NewAcc = Acc * Left,
      {NewAcc2, NewZeros} = remove_trailing_zeros(NewAcc, 0),
      product_and_trailing_zeros(Left + 1, Right, NewAcc2, AccZeros + NewZeros)
  end.

remove_trailing_zeros(N, Zeros) when N rem 10 == 0 ->
  remove_trailing_zeros(N div 10, Zeros + 1);
remove_trailing_zeros(N, Zeros) ->
  {N, Zeros}.

first_and_last_5(Left, Right) ->
  First5 = first_5_digits(Left, Right, 1),
  Last5 = last_5_digits(Left, Right, 1),
  {integer_to_list(First5), integer_to_list(Last5)}.

first_5_digits(Left, Right, Acc) when Left > Right ->
  Acc;
first_5_digits(Left, Right, Acc) ->
  NewAcc = Acc * Left,
  TruncatedAcc = NewAcc div (10 ** (integer:min(integer:floor(math:log10(NewAcc)) - 4 , 1000))),
  first_5_digits(Left + 1, Right, TruncatedAcc).

last_5_digits(Left, Right, Acc) when Left > Right ->
  Acc rem 100000;
last_5_digits(Left, Right, Acc) ->
  NewAcc = Acc * Left,
  last_5_digits(Left + 1, Right, NewAcc).