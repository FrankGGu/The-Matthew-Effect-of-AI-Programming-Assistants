-module(max_product_palindromes).
-export([max_product/1]).

max_product(S) ->
  Len = length(S),
  {L, R} = get_max_len_palindromes(S, Len),
  lists:max([L1 * R1 || {L1, R1} <- product(L, R)]).

get_max_len_palindromes(S, Len) ->
  L = get_max_len_palindrome_prefixes(S, Len),
  R = get_max_len_palindrome_suffixes(S, Len),
  {L, R}.

get_max_len_palindrome_prefixes(S, Len) ->
  get_max_len_palindrome_prefixes(S, Len, []).

get_max_len_palindrome_prefixes(S, Len, Acc) ->
  get_max_len_palindrome_prefixes(S, Len, 0, Acc).

get_max_len_palindrome_prefixes(_S, Len, I, Acc) when I >= Len ->
  Acc;
get_max_len_palindrome_prefixes(S, Len, I, Acc) ->
  Sub = lists:sublist(S, 1, I+1),
  case is_palindrome(Sub) of
    true ->
      get_max_len_palindrome_prefixes(S, Len, I + 1, [length(Sub)|Acc]);
    false ->
      get_max_len_palindrome_prefixes(S, Len, I + 1, Acc)
  end.

get_max_len_palindrome_suffixes(S, Len) ->
  get_max_len_palindrome_suffixes(S, Len, []).

get_max_len_palindrome_suffixes(S, Len, Acc) ->
  get_max_len_palindrome_suffixes(S, Len, 0, Acc).

get_max_len_palindrome_suffixes(_S, Len, I, Acc) when I >= Len ->
  Acc;
get_max_len_palindrome_suffixes(S, Len, I, Acc) ->
  Sub = lists:sublist(S, Len - I, I+1),
  case is_palindrome(Sub) of
    true ->
      get_max_len_palindrome_suffixes(S, Len, I + 1, [length(Sub)|Acc]);
    false ->
      get_max_len_palindrome_suffixes(S, Len, I + 1, Acc)
  end.

is_palindrome(S) ->
  S == lists:reverse(S).

product(L1, L2) ->
  product(L1, L2, []).

product([], _, Acc) ->
  lists:reverse(Acc);
product([H1|T1], L2, Acc) ->
  NewAcc = lists:foldl(fun(H2, Acc2) -> [{H1, H2}|Acc2] end, Acc, L2),
  product(T1, L2, NewAcc).