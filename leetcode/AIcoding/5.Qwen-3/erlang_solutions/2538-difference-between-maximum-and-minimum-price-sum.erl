-module(solution).
-export([maxMinDifference/1]).

maxMinDifference(Prices) ->
    lists:foldl(fun(Price, {Max, Min}) -> {erlang:max(Price, Max), erlang:min(Price, Min)} end, {hd(Prices), hd(Prices)}, Prices).

main(_) ->
    io:get_line(""),
    PriceList = string:tokens(io:get_line(""), " \n"),
    Prices = lists:map(fun erlang:list_to_integer/1, PriceList),
    Result = maxMinDifference(Prices),
    io:format("~p~n", [Result]).