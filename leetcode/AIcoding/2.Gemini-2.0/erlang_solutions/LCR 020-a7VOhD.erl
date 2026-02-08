-module(palindromic_substrings).
-export([countSubstrings/1]).

countSubstrings(S) ->
  Len = length(S),
  countPalindromes(S, Len).

countPalindromes(S, Len) ->
  countPalindromesHelper(S, Len, 0, 0).

countPalindromesHelper(S, Len, Index, Count) ->
  if Index >= Len then
    Count
  else
    Count1 = countAroundCenter(S, Index, Index, Count),
    Count2 = countAroundCenter(S, Index, Index + 1, Count1),
    countPalindromesHelper(S, Len, Index + 1, Count2)
  end.

countAroundCenter(S, Left, Right, Count) ->
  countAroundCenterHelper(S, Left, Right, Count).

countAroundCenterHelper(S, Left, Right, Count) ->
  if Left >= 0 andalso Right < length(S) then
    LeftChar = lists:nth(Left + 1, S),
    RightChar = lists:nth(Right + 1, S),
    if LeftChar == RightChar then
      countAroundCenterHelper(S, Left - 1, Right + 1, Count + 1)
    else
      Count
    end
  else
    Count
  end.