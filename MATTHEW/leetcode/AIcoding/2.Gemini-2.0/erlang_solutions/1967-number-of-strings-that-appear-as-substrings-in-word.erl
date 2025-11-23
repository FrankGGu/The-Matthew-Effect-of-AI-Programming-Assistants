-module(num_matching_subseq).
-export([num_matching_subseq/2]).

num_matching_subseq(Patterns, Word) ->
  lists:foldl(
    fun(Pattern, Acc) ->
      case string:str(Word, Pattern) of
        nomatch ->
          Acc;
        _ ->
          Acc + 1
      end
    end,
    0,
    Patterns
  ).