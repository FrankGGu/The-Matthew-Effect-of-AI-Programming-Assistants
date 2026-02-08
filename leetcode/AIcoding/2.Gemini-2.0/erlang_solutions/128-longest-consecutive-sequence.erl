-module(longest_consecutive_sequence).
-export([longest_consecutive/1]).

longest_consecutive(Nums) ->
  Set = sets:from_list(Nums),
  longest_consecutive(Set, Nums, 0).

longest_consecutive(_Set, [], Len) ->
  Len;
longest_consecutive(Set, [Num|Rest], Len) ->
  case sets:is_element(Num, Set) of
    true ->
      case sets:is_element(Num - 1, Set) of
        true ->
          longest_consecutive(Set, Rest, Len);
        false ->
          SeqLen = longest_consecutive_helper(Set, Num, 1),
          NewLen = max(Len, SeqLen),
          longest_consecutive(Set, Rest, NewLen)
      end;
    false ->
      longest_consecutive(Set, Rest, Len)
  end.

longest_consecutive_helper(Set, Num, Len) ->
  case sets:is_element(Num + 1, Set) of
    true ->
      longest_consecutive_helper(Set, Num + 1, Len + 1);
    false ->
      Len
  end.