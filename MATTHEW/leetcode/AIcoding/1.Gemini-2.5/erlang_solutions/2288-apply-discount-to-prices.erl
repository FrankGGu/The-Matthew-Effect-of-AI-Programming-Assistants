-module(solution).
-export([discountPrices/2]).

discountPrices(Sentence, Discount) ->
    Words = string:tokens(Sentence, " "),
    DiscountFactor = 1.0 - (Discount / 100.0),

    NewWords = lists:map(fun(Word) ->
                                 case is_price(Word) of
                                     {true, PriceValue} ->
                                         DiscountedPrice = PriceValue * DiscountFactor,
                                         io_lib:format("~$0.2f", [DiscountedPrice])
                                     _ ->
                                         Word
                                 end
                         end, Words),

    string:join(NewWords, " ").

is_price(Word) ->
    case length(Word) > 1 andalso hd(Word) == $$ of
        true ->
            PriceString = tl(Word),
            case catch string:to_integer(PriceString) of
                {PriceValue, []} ->
                    {true, PriceValue};
                _ ->
                    {false, 0}
            end;
        _ ->
            {false, 0}
    end.