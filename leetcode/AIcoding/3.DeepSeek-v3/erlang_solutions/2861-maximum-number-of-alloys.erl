-spec max_number_of_alloys(N :: integer(), K :: integer(), Budget :: integer(), Composition :: [[integer()]], Stock :: [integer()], Cost :: [integer()]) -> integer().
max_number_of_alloys(N, K, Budget, Composition, Stock, Cost) ->
    MaxAlloys = 0,
    lists:foldl(fun(C, Acc) ->
        Low = 0,
        High = Budget + lists:sum(Stock),
        binary_search(Low, High, Budget, C, Stock, Cost, Acc)
    end, MaxAlloys, Composition).

binary_search(Low, High, Budget, Composition, Stock, Cost, MaxAlloys) when Low =< High ->
    Mid = (Low + High) div 2,
    case can_produce(Mid, Composition, Stock, Cost, Budget) of
        true ->
            binary_search(Mid + 1, High, Budget, Composition, Stock, Cost, max(MaxAlloys, Mid));
        false ->
            binary_search(Low, Mid - 1, Budget, Composition, Stock, Cost, MaxAlloys)
    end;
binary_search(_Low, _High, _Budget, _Composition, _Stock, _Cost, MaxAlloys) ->
    MaxAlloys.

can_produce(Alloys, Composition, Stock, Cost, Budget) ->
    Needed = lists:zipwith(fun(C, S) -> max(0, C * Alloys - S) end, Composition, Stock),
    TotalCost = lists:sum(lists:zipwith(fun(N, C) -> N * C end, Needed, Cost)),
    TotalCost =< Budget.