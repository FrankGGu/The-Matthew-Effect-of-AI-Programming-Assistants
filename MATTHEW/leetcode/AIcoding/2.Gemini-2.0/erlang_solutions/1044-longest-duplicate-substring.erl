-module(longest_duplicate_substring).
-export([longest_dup_substring/1]).

longest_dup_substring(S) ->
  longest_dup_substring(S, 0, length(S) - 1).

longest_dup_substring(S, Low, High) ->
  case Low > High of
    true -> "";
    false ->
      Mid = (Low + High + 1) div 2,
      case check(S, Mid) of
        {true, Dup} ->
          case longest_dup_substring(S, Mid, High) of
            Sub when length(Sub) > length(Dup) -> Sub;
            _ -> Dup
          end;
        false ->
          longest_dup_substring(S, Low, Mid - 1)
      end
  end.

check(S, Len) ->
  case length(S) < Len of
    true -> false;
    false ->
      check(S, Len, lists:seq(1, length(S) - Len + 1), [])
  end.

check(_S, _Len, [], _) ->
  false.

check(S, Len, [Start | Rest], Seen) ->
  Sub = lists:sublist(S, Start, Len),
  case lists:member(Sub, Seen) of
    true -> {true, Sub};
    false -> check(S, Len, Rest, [Sub | Seen])
  end.