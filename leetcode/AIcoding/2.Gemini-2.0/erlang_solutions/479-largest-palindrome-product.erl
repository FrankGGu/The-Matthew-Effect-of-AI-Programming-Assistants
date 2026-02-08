-module(largest_palindrome_product).
-export([largest_palindrome/1]).

largest_palindrome(N) ->
  UpperLimit = math:pow(10, N) - 1,
  LowerLimit = math:pow(10, N - 1),
  largest_palindrome_helper(UpperLimit, LowerLimit).

largest_palindrome_helper(UpperLimit, LowerLimit) ->
  case N =< 1 of
    true -> 9;
    false ->
      find_max_palindrome(UpperLimit, LowerLimit, 0)
  end.

find_max_palindrome(I, LowerLimit, MaxPalindrome) ->
  case I < LowerLimit of
    true -> MaxPalindrome;
    false ->
      Result = find_palindrome_product(I, LowerLimit, MaxPalindrome),
      find_max_palindrome(I - 1, LowerLimit, Result)
  end.

find_palindrome_product(I, LowerLimit, MaxPalindrome) ->
  find_palindrome_product_helper(I, I, LowerLimit, MaxPalindrome).

find_palindrome_product_helper(I, J, LowerLimit, MaxPalindrome) ->
  case J < LowerLimit of
    true -> MaxPalindrome;
    false ->
      Product = I * J,
      case Product =< MaxPalindrome of
        true -> MaxPalindrome;
        false ->
          case is_palindrome(integer_to_list(Product)) of
            true ->
              find_palindrome_product_helper(I, J - 1, LowerLimit, Product);
            false ->
              find_palindrome_product_helper(I, J - 1, LowerLimit, MaxPalindrome)
          end
      end
  end.

is_palindrome(List) ->
  List =:= lists:reverse(List).