-module(palindrome_pairs).
-export([palindrome_pairs/1]).

palindrome_pairs(Words) ->
  palindrome_pairs(Words, []).

palindrome_pairs([], Acc) ->
  Acc;
palindrome_pairs([Word | Rest], Acc) ->
  N = length(Rest),
  NewPairs = 
    lists:foldl(
      fun(Index, A) ->
        OtherWord = lists:nth(Index+1,Rest),
        case is_palindrome(Word ++ OtherWord) of
          true -> [ {lists:seq(1, length(Words)) -- [length(Words) - length(Rest) + Index + 1] , length(Words) - length(Rest) + Index + 1} | A];
          false -> A
        end
      end,
      [],
      lists:seq(0, N-1)
    ),
  NewPairs2 =
    lists:foldl(
      fun(Index, A) ->
        OtherWord = lists:nth(Index+1, Rest),
        case is_palindrome(OtherWord ++ Word) of
          true -> [ {length(Words) - length(Rest) + Index + 1, lists:seq(1, length(Words)) -- [length(Words) - length(Rest)]} | A];
          false -> A
        end
      end,
      [],
      lists:seq(0, N-1)
    ),
  palindrome_pairs(Rest, Acc ++ NewPairs ++ NewPairs2).

is_palindrome(Str) ->
  Str == lists:reverse(Str).