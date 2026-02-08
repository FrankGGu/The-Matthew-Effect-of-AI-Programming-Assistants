-module(find_closest_palindrome).
-export([nearestPalindromic/1]).

nearestPalindromic(N) ->
  Num = list_to_integer(N),
  Len = length(N),
  Cands = [
    math:pow(10, Len) - 1,
    math:pow(10, Len + 1) + 1,
    Prefix = list_to_integer(lists:sublist(N, 1, (Len + 1) div 2)),
    makePalindrome(integer_to_list(Prefix - 1), Len),
    makePalindrome(integer_to_list(Prefix), Len),
    makePalindrome(integer_to_list(Prefix + 1), Len)
  ],

  FiltCands = lists:filter(fun(X) -> X /= Num end, Cands),

  lists:foldl(fun(Cand, Acc) ->
      DiffCand = abs(Cand - Num),
      DiffAcc = abs(Acc - Num),
      if DiffCand < DiffAcc ->
        Cand
      else if DiffCand == DiffAcc ->
        min(Cand, Acc)
      else
        Acc
      end
    end, hd(FiltCands), tl(FiltCands)).

makePalindrome(Prefix, Len) ->
  PrefixStr = integer_to_list(Prefix),
  if Len rem 2 == 0 then
    list_to_integer(PrefixStr ++ lists:reverse(PrefixStr))
  else
    list_to_integer(PrefixStr ++ lists:reverse(tl(PrefixStr)))
  end.