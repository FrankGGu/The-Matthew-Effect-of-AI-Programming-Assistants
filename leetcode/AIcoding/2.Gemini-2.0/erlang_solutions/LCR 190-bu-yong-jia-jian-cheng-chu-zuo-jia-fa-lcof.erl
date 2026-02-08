-module(encryption_arithmetic).
-export([is_solvable/1]).

is_solvable(words) ->
  Chars = lists:usort(lists:flatten(words)),
  N = length(Chars),
  Perms = permutations(Chars),
  lists:any(fun(Perm) ->
               Map = lists:zip(Chars, Perm),
               Values = [word_to_num(Word, Map) || Word <- words],
               case Values of
                 [Num1, Num2, Result] ->
                   not has_leading_zeroes(words, Map) andalso Num1 + Num2 =:= Result;
                 _ ->
                   false
               end
           end, Perms).

word_to_num(Word, Map) ->
  lists:foldl(fun(Char, Acc) ->
                  Acc * 10 + lists:keyfind(Char, 1, Map)
              end, 0, Word).

has_leading_zeroes(Words, Map) ->
  lists:any(fun(Word) ->
               length(Word) > 1 andalso lists:keyfind(lists:nth(1, Word), 1, Map) =:= 0
           end, Words).

permutations([]) -> [[]];
permutations(List) ->
  lists:flatten([
    begin
      Element = lists:nth(I, List),
      Rest = lists:delete(Element, List),
      [ [Element | P] || P <- permutations(Rest)]
    end
    || I <- lists:seq(1, length(List))
  ]).