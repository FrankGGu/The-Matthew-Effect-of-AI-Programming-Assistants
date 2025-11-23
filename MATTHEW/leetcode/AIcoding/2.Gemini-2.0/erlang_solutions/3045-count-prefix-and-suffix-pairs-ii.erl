-module(count_prefix_suffix_pairs_ii).
-export([solve/1]).

solve(Words) ->
  solve(Words, 0).

solve([], Count) ->
  Count;
solve([Word | Rest], Count) ->
  solve(Rest, Count + count_pairs(Word, Rest)).

count_pairs(Word, Words) ->
  count_pairs(Word, Words, 0).

count_pairs(_, [], Count) ->
  Count;
count_pairs(Word, [Other | Rest], Count) ->
  case is_prefix_suffix(Word, Other) of
    true ->
      count_pairs(Word, Rest, Count + 1);
    false ->
      count_pairs(Word, Rest, Count)
  end.

is_prefix_suffix(Word1, Word2) ->
  Len1 = length(Word1),
  Len2 = length(Word2),
  case Len1 > Len2 of
    true ->
      false;
    false ->
      case string:prefix(Word2, Word1) andalso string:suffix(Word2, Word1) of
        true ->
          true;
        false ->
          false
      end
  end.