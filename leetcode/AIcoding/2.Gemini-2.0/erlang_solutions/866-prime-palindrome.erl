-module(prime_palindrome).
-export([primePalindrome/1]).

primePalindrome(N) ->
  case N > 9989900 then
    100030001
  else
    find_prime_palindrome(N)
  end.

find_prime_palindrome(N) ->
  case N rem 2 == 0 then
    find_prime_palindrome(N + 1)
  else
    case is_palindrome_prime(N) of
      true ->
        N;
      false ->
        find_prime_palindrome(N + 2)
    end
  end.

is_palindrome_prime(N) ->
  is_palindrome(integer_to_list(N)) andalso is_prime(N).

is_palindrome(L) ->
  L == lists:reverse(L).

is_prime(N) ->
  is_prime(N, 2).

is_prime(N, I) ->
  case I * I > N of
    true ->
      true;
    false ->
      case N rem I == 0 of
        true ->
          false;
        false ->
          is_prime(N, I + 1)
      end
  end.