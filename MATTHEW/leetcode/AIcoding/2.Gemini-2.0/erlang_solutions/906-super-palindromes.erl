-module(super_palindromes).
-export([superpalindromes/1]).

is_palindrome(N) ->
  S = integer_to_list(N),
  lists:reverse(S) == S.

superpalindromes(Right) ->
  Nums = [1, 2, 3, 4, 5, 6, 7, 8, 9],
  superpalindromes_helper(Nums, Right, 0).

superpalindromes_helper([], _, Acc) ->
  Acc;
superpalindromes_helper([N | Rest], Right, Acc) ->
  Square = N * N,
  case Square > Right of
    true ->
      Acc;
    false ->
      NewAcc = case is_palindrome(Square) of
        true -> Acc + 1;
        false -> Acc
      end,
      Digits = integer_to_list(N),
      Length = length(Digits),
      NewNums = gen_palindromes(Length + 1,Digits),
      NewNums2 = gen_palindromes(Length + 2,Digits),
      superpalindromes_helper(Rest ++ NewNums ++ NewNums2, Right, NewAcc)
  end.

gen_palindromes(Len, Digits) ->
  case Len of
    1 -> [1, 2, 3, 4, 5, 6, 7, 8, 9];
    2 -> [11, 22, 33, 44, 55, 66, 77, 88, 99];
    _ ->
      HalfLen = (Len + 1) div 2,
      Start = math:pow(10, HalfLen -1),
      End = math:pow(10, HalfLen) - 1,
      gen_palindromes_range(Start, End, Len)
  end.

gen_palindromes_range(Start, End, Len) ->
  gen_palindromes_range_helper(Start, End, Len, []).

gen_palindromes_range_helper(Start, End, Len, Acc) ->
  case Start > End of
    true ->
      Acc;
    false ->
      Str = integer_to_list(Start),
      Palindrome = case Len rem 2 of
        0 ->
          Str ++ lists:reverse(Str);
        1 ->
          Str ++ lists:reverse(tl(Str))
      end,
      gen_palindromes_range_helper(Start + 1, End, Len, Acc ++ [list_to_integer(Palindrome)])
  end.