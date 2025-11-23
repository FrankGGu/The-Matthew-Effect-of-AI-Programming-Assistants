-module(unique_palindromes).
-export([num_unique_palindromes/1]).

num_unique_palindromes(S) ->
  num_unique_palindromes(S, 0).

num_unique_palindromes(S, Acc) ->
  case string:len(S) of
    0 ->
      Acc;
    Len ->
      num_unique_palindromes(S, 0, 0, lists:seq($a, $z), [], Acc, Len)
  end.

num_unique_palindromes(_S, _Idx, _CharIdx, [], Seen, Acc, _Len) ->
  lists:foldl(fun(_, A) -> A + 1 end, 0, Seen);
num_unique_palindromes(S, Idx, CharIdx, [Char | Rest], Seen, Acc, Len) ->
  First = string:chr(S, Char);
  case First of
    -1 ->
      num_unique_palindromes(S, Idx, CharIdx + 1, Rest, Seen, Acc, Len);
    _ ->
      Last = string:rchr(S, Char);
      case Last of
        -1 ->
          num_unique_palindromes(S, Idx, CharIdx + 1, Rest, Seen, Acc, Len);
        _ ->
          Sub = string:sub(S, First + 1, Last - First - 1);
          UniqueMiddle = lists:usort([C || C <- string:to_list(Sub)]);
          Count = length(UniqueMiddle);
          case lists:member(Char, Seen) of
            true ->
              num_unique_palindromes(S, Idx, CharIdx + 1, Rest, Seen, Acc, Len);
            false ->
              num_unique_palindromes(S, Idx, CharIdx + 1, Rest, [Char | Seen], Acc + Count, Len)
          end
      end
  end.