-module(solution).
-export([discount_prices/2]).

discount_prices(Sentence, Discount) ->
    Words = string:tokens(Sentence, " "),
    ProcessedWords = lists:map(fun(Word) -> process_word(Word, Discount) end, Words),
    string:join(ProcessedWords, " ").

process_word(Word, Discount) ->
    case is_price(Word) of
        true ->
            PriceStr = string:sub_string(Word, 2),
            case string:to_float(PriceStr) of
                {error, _} ->
                    case string:to_integer(PriceStr) of
                        {error, _} -> Word;
                        {Price, _} -> apply_discount(Price, Discount)
                    end;
                {Price, _} -> apply_discount(Price, Discount)
            end;
        false -> Word
    end.

is_price(Word) ->
    case string:length(Word) of
        Len when Len < 2 -> false;
        _ ->
            case string:sub_string(Word, 1, 1) of
                "$" ->
                    Rest = string:sub_string(Word, 2),
                    string:is_empty(Rest) orelse lists:all(fun(C) -> C >= $0 andalso C =< $9 orelse C =:= $. end, Rest);
                _ -> false
            end
    end.

apply_discount(Price, Discount) ->
    Discounted = Price * (100 - Discount) / 100,
    Formatted = io_lib:format("~.2f", [Discounted]),
    lists:flatten("$" ++ Formatted).