-spec max_power(stations :: [integer()], r :: integer(), k :: integer()) -> integer().
max_power(Stations, R, K) ->
    N = length(Stations),
    Power = list_to_tuple(Stations),
    Low = 0,
    High = lists:sum(Stations) + K,
    binary_search(Low, High, Power, N, R, K).

binary_search(Low, High, Power, N, R, K) when Low < High ->
    Mid = (Low + High + 1) div 2,
    case is_possible(Power, N, R, K, Mid) of
        true -> binary_search(Mid, High, Power, N, R, K);
        false -> binary_search(Low, Mid - 1, Power, N, R, K)
    end;
binary_search(Low, _High, _Power, _N, _R, _K) ->
    Low.

is_possible(Power, N, R, K, Target) ->
    Extra = array:new([{size, N}, {default, 0}]),
    {IsPossible, _} = lists:foldl(
        fun(I, {Possible, CurrentK}) ->
            if not Possible -> {false, CurrentK};
               true ->
                    ExtraI = array:get(I, Extra),
                    Total = array:get(I, Power) + ExtraI,
                    if Total >= Target -> {true, CurrentK};
                       true ->
                            Needed = Target - Total,
                            if CurrentK + Needed > K -> {false, CurrentK};
                               true ->
                                    NewExtra = array:set(I + 2 * R + 1, array:get(I + 2 * R + 1, Extra) - Needed, Extra),
                                    NewExtra2 = array:set(min(I + R + 1, N), array:get(min(I + R + 1, N), NewExtra) + Needed, NewExtra),
                                    {true, CurrentK + Needed}
                            end
                    end
            end
        end,
        {true, 0},
        lists:seq(0, N - 1)),
    IsPossible.