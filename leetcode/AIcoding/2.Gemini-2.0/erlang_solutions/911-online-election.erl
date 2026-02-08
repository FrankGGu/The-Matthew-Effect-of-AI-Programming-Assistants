-module(online_election).
-export([new/1, q/2]).

new(persons) ->
    {Winners, Times} = lists:foldl(fun({Person, Time}, {WinnersAcc, TimesAcc}) ->
                                        NewWinnersAcc =
                                            case WinnersAcc of
                                                [] -> [Person];
                                                [LastWinner | _] ->
                                                    Counts = lists:foldl(fun(P, Acc) ->
                                                                              case maps:is_key(P, Acc) of
                                                                                  true -> maps:update(P, maps:get(P, Acc) + 1, Acc);
                                                                                  false -> maps:put(P, 1, Acc)
                                                                              end
                                                                          end, maps:new(), WinnersAcc),
                                                    NewCount = case maps:is_key(Person, Counts) of
                                                                   true -> maps:get(Person, Counts) + 1;
                                                                   false -> 1
                                                               end,

                                                    MaxCount = lists:max([maps:get(W, Counts) || W <- maps:keys(Counts)]),

                                                    if
                                                        NewCount >= MaxCount -> [Person | WinnersAcc];
                                                        true -> [LastWinner | WinnersAcc]
                                                    end
                                            end,
                                        {[lists:nth(1, NewWinnersAcc) | WinnersAcc], [Time | TimesAcc]}
                                    end, {[], []}, persons),
    {lists:reverse(Winners), lists:reverse(Times)}.

q({Winners, Times}, t) ->
    lists:nth(find_index(Times, t) + 1, Winners).

find_index(Times, t) ->
    find_index(Times, t, length(Times) - 1).

find_index(Times, t, Index) ->
    case Index of
        -1 -> -1;
        _ ->
            case lists:nth(Index + 1, Times) =< t of
                true -> Index;
                false -> find_index(Times, t, Index - 1)
            end
    end.