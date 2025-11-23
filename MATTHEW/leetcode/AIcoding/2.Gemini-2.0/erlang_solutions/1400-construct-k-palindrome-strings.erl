-module(construct_k_palindrome_strings).
-export([can_construct_k_palindrome/2]).

can_construct_k_palindrome(S, K) ->
  Len = length(S),
  if K > Len then
    false
  else
    Counts = lists:foldl(
      fun(Char, Acc) ->
        case maps:get(Char, Acc, 0) of
          0 -> maps:put(Char, 1, Acc);
          N -> maps:put(Char, N + 1, Acc)
        end
      end,
      #{},
      S
    ),
    Odds = lists:foldl(
      fun(V, Acc) ->
        if V rem 2 == 1 then
          Acc + 1
        else
          Acc
        end
      end,
      0,
      maps:values(Counts)
    ),
    Odds =< K.