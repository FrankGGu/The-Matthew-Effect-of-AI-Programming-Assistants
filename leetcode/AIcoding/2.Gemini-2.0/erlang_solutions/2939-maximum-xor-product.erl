-module(maximum_xor_product).
-export([maximum_xor_product/3]).

maximum_xor_product(A, B, N) ->
  maximum_xor_product(A, B, N, 0).

maximum_xor_product(A, B, 0, Acc) ->
  Acc rem 1000000007;
maximum_xor_product(A, B, N, Acc) ->
  Mask = 1 bsl (N - 1),
  case {A band Mask, B band Mask} of
    {0, 0} ->
      if A =< B then
        maximum_xor_product(A + Mask, B, N - 1, max(Acc, ((A + Mask) rem 1000000007) * ((B - Mask) rem 1000000007) rem 1000000007))
      else
        maximum_xor_product(A, B + Mask, N - 1, max(Acc, ((A - Mask) rem 1000000007) * ((B + Mask) rem 1000000007) rem 1000000007))
      end;
    {0, Mask} ->
      maximum_xor_product(A + Mask, B - Mask, N - 1, Acc);
    {Mask, 0} ->
      maximum_xor_product(A - Mask, B + Mask, N - 1, Acc);
    {Mask, Mask} ->
      maximum_xor_product(A, B, N - 1, ((Acc rem 1000000007) + ((A rem 1000000007) * (B rem 1000000007) rem 1000000007)) rem 1000000007)
  end.