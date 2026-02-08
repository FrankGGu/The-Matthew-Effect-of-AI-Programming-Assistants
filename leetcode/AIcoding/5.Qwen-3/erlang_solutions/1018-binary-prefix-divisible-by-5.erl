-module(binary_prefix_divisible_by_5).
-export([prefixes_divisible_by_5/1]).

prefixes_divisible_by_5(Bits) ->
    prefixes_divisible_by_5(Bits, 0, []).

prefixes_divisible_by_5([], _, Result) ->
    lists:reverse(Result);
prefixes_divisible_by_5([Bit | Rest], Acc, Result) ->
    Acc2 = (Acc * 2 + Bit) rem 5,
    Result2 = case Acc2 of
                  0 -> [true | Result];
                  _ -> [false | Result]
              end,
    prefixes_divisible_by_5(Rest, Acc2, Result2).