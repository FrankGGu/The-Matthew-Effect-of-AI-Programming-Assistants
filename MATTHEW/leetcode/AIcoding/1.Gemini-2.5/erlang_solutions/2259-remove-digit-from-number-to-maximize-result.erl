-module(solution).
-export([removeDigit/2]).

removeDigit(Number, Digit) ->
    remove_digit_and_maximize(Number, Digit, 1, []).

remove_digit_and_maximize(Number, Digit, Index, AccMaxResult) ->
    case Index =< length(Number) of
        true ->
            Char = lists:nth(Index, Number),
            case Char == Digit of
                true ->
                    % Form the new string by removing Char at Index
                    Prefix = lists:sublist(Number, 1, Index - 1),
                    Suffix = lists:nthtail(Index + 1, Number),
                    CurrentResult = Prefix ++ Suffix,

                    NewAccMaxResult = case AccMaxResult of
                        [] -> CurrentResult; % First valid result
                        _ ->
                            case CurrentResult > AccMaxResult of
                                true -> CurrentResult;
                                false -> AccMaxResult
                            end
                    end,
                    remove_digit_and_maximize(Number, Digit, Index + 1, NewAccMaxResult);
                false ->
                    remove_digit_and_maximize(Number, Digit, Index + 1, AccMaxResult)
            end;
        false ->
            AccMaxResult
    end.