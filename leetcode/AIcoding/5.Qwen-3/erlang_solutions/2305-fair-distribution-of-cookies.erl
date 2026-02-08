-module(fair_distribution_of_cookies).
-export([findMaximumEconomicValue/2]).

findMaximumEconomicValue(Cookies, K) ->
    lists:sort(Cookies),
    findMaximumEconomicValue(Cookies, K, 0, []).

findMaximumEconomicValue([], _, _, Result) ->
    lists:max(Result);
findMaximumEconomicValue([C | Rest], K, Index, Result) ->
    if
        length(Result) < K ->
            NewResult = lists:append(Result, [C]),
            findMaximumEconomicValue(Rest, K, Index + 1, NewResult);
        true ->
            case lists:nth(Index, Result) of
                Val when Val < C ->
                    NewResult = lists:sublist(Result, Index) ++ [C] ++ lists:nthtail(Index + 1, Result),
                    findMaximumEconomicValue(Rest, K, Index + 1, NewResult);
                _ ->
                    findMaximumEconomicValue(Rest, K, Index + 1, Result)
            end
    end.