-module(solution).
-export([subscription_conversion/3]).

subscription_conversion(Subscription, Duration, Conversion) ->
    F = fun({Start, End, Rate}, Acc) ->
            case (Subscription >= Start) and (Subscription =< End) of
                true -> Rate;
                false -> Acc
            end
        end,
    Rate = lists:foldl(F, 0, Conversion),
    round(Subscription * Duration * Rate / 100).