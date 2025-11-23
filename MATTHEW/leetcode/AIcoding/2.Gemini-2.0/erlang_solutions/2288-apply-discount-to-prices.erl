-module(apply_discount).
-export([apply_discount/2]).

apply_discount(Sentence, Discount) ->
  Words = string:split(Sentence, " ", all),
  apply_discount_helper(Words, Discount, []).

apply_discount_helper([], _Discount, Acc) ->
  lists:reverse(Acc);
apply_discount_helper([Word | Rest], Discount, Acc) ->
  case string:starts_with(Word, "$") of
    true ->
      try
        AmountStr = string:substr(Word, 2, length(Word) - 1),
        Amount = list_to_float(AmountStr),
        DiscountedAmount = Amount * (100 - Discount) / 100,
        FormattedAmount = io_lib:format("~.2f", [DiscountedAmount]),
        apply_discount_helper(Rest, Discount, ["$" ++ lists:flatten(FormattedAmount) | Acc])
      catch
        _:_ ->
          apply_discount_helper(Rest, Discount, [Word | Acc])
      end;
    false ->
      apply_discount_helper(Rest, Discount, [Word | Acc])
  end.