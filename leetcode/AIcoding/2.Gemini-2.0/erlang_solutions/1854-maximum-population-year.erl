-module(maximum_population_year).
-export([maximum_population/1]).

maximum_population(Logs) ->
    maximum_population(Logs, 1950, 2050, lists:seq(1950, 2050), []).

maximum_population([], _MinYear, _MaxYear, Years, Acc) ->
    lists:nth(lists:keyfind(lists:max([Y || {_X, Y} <- Acc]), 2, Acc) + 1, Years).

maximum_population([ [Birth, Death] | Rest], MinYear, MaxYear, Years, Acc) ->
    NewAcc = lists:map(fun(Year) ->
                                  case Birth =< Year andalso Year < Death of
                                      true ->
                                          case lists:keyfind(Year, 1, Acc) of
                                              false ->
                                                  {Year, 1};
                                              {Year, Count} ->
                                                  {Year, Count + 1}
                                          end;
                                      false ->
                                          case lists:keyfind(Year, 1, Acc) of
                                              false ->
                                                  {Year, 0};
                                              {Year, Count} ->
                                                  {Year, Count}
                                          end
                                  end
                          end, Years),
    maximum_population(Rest, MinYear, MaxYear, Years, NewAcc).