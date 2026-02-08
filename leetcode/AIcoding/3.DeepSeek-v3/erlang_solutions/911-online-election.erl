-module(top_voted_candidate).

-export([init/1, q/2]).

-record(state, {times, leaders}).

init(Persons, Times) ->
    Count = maps:new(),
    Leaders = lists:foldl(fun({P, T}, {L, C}) ->
                                  NewC = maps:update_with(P, fun(V) -> V + 1 end, 1, C),
                                  MaxV = case L of
                                             [] -> -1;
                                             _ -> maps:get(hd(L), NewC)
                                         end,
                                  CurrV = maps:get(P, NewC),
                                  NewL = if CurrV >= MaxV -> [P | L];
                                            true -> L
                                         end,
                                  {NewL, NewC}
                          end, {[], Count}, lists:zip(Persons, Times)),
    #state{times = Times, leaders = lists:reverse(element(1, Leaders))}.

q(T, #state{times = Times, leaders = Leaders}) ->
    Index = binary_search(Times, T),
    lists:nth(Index + 1, Leaders).

binary_search(Times, T) ->
    binary_search(Times, T, 0, length(Times) - 1).

binary_search(Times, T, Left, Right) when Left =< Right ->
    Mid = (Left + Right) div 2,
    case lists:nth(Mid + 1, Times) of
        MidT when MidT =< T ->
            binary_search(Times, T, Mid + 1, Right);
        _ ->
            binary_search(Times, T, Left, Mid - 1)
    end;
binary_search(_, _, Left, _) ->
    Left - 1.