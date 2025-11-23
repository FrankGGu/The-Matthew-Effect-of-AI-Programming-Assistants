-module(smallest_letter_greater_than_target).
-export([next_greatest_letter/2]).

next_greatest_letter(Letters, Target) ->
  lists:foldl(
    fun(Letter, Acc) ->
      if
        Letter > Target -> Letter;
        true -> Acc
      end
    end,
    hd(Letters),
    Letters
  ).