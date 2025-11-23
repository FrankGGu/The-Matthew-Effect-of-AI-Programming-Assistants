-module(longestPalindrome).
-export([longestPalindrome/1]).

longestPalindrome(S) ->
  Len = length(S),
  case Len < 2 of
    true -> S;
    false ->
      longestPalindromeHelper(S, Len)
  end.

longestPalindromeHelper(S, Len) ->
  longestPalindromeHelper(S, Len, 0, 0, 0, []).

longestPalindromeHelper(S, Len, Start, MaxLen, I, Acc) ->
  case I < Len of
    true ->
      {Start1, MaxLen1} = expandAroundCenter(S, I, I, Len, 0, 0),
      {Start2, MaxLen2} = expandAroundCenter(S, I, I + 1, Len, 0, 0),
      case MaxLen1 > MaxLen2 of
        true ->
          case MaxLen1 > MaxLen of
            true ->
              longestPalindromeHelper(S, Len, Start1, MaxLen1, I + 1, Acc);
            false ->
              longestPalindromeHelper(S, Len, Start, MaxLen, I + 1, Acc)
          end;
        false ->
          case MaxLen2 > MaxLen of
            true ->
              longestPalindromeHelper(S, Len, Start2, MaxLen2, I + 1, Acc);
            false ->
              longestPalindromeHelper(S, Len, Start, MaxLen, I + 1, Acc)
          end
      end;
    false ->
      list_to_binary(lists:sublist(binary_to_list(S), Start + 1, MaxLen))
  end.

expandAroundCenter(S, Left, Right, Len, Start, MaxLen) ->
  expandAroundCenterHelper(S, Left, Right, Len, 0, 0, Start, MaxLen).

expandAroundCenterHelper(S, Left, Right, Len, Start, MaxLen, AccStart, AccMaxLen) ->
  case Left >= 0 andalso Right < Len andalso element(Left + 1, binary_to_list(S)) == element(Right + 1, binary_to_list(S)) of
    true ->
      expandAroundCenterHelper(S, Left - 1, Right + 1, Len, Left - 1, Right - Left + 1, AccStart, AccMaxLen);
    false ->
      Start1 = Left + 1,
      MaxLen1 = Right - Left - 1,
      case MaxLen1 > AccMaxLen of
        true ->
          {Start1, MaxLen1};
        false ->
          {AccStart, AccMaxLen}
      end
  end.