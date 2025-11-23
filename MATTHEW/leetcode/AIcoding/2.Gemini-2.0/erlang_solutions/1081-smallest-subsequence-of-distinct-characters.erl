-module(smallestSubsequence).
-export([smallestSubsequence/1]).

smallestSubsequence(S) ->
  smallestSubsequence(S, [], []).

smallestSubsequence([], Acc, _) ->
  lists:reverse(Acc);
smallestSubsequence([H|T], Acc, Seen) ->
  smallestSubsequence(T, processChar(H, Acc, Seen, T), Seen).

processChar(H, [], _, T) ->
  [H];
processChar(H, Acc, Seen, T) ->
  case lists:member(H, Seen) of
    true ->
      Acc;
    false ->
      processCharHelper(H, Acc, Seen, T)
  end.

processCharHelper(H, [], _, _) ->
  [H];
processCharHelper(H, Acc, Seen, T) ->
  case canRemoveLast(Acc, T) of
    true ->
      case lastIsGreater(H, Acc) of
        true ->
          [H|processCharHelper(H, lists:droplast(Acc), Seen, T)];
        false ->
          Acc ++ [H]
      end;
    false ->
      Acc ++ [H]
  end.

canRemoveLast([], _) ->
  false;
canRemoveLast(Acc, T) ->
  Last = lists:last(Acc),
  lists:member(Last, T).

lastIsGreater(H, Acc) ->
  Last = lists:last(Acc),
  H < Last.

lists:droplast(List) ->
  lists:reverse(tl(lists:reverse(List))).