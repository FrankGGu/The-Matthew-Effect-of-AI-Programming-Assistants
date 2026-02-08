-spec minimum_cost(Cost :: [integer()]) -> integer().
minimum_cost(Cost) ->
    Sorted = lists:reverse(lists:sort(Cost)),
    calculate(Sorted, 0).

calculate([], Total) -> Total;
calculate([_], Total) -> Total;
calculate([A, B | Rest], Total) ->
    calculate(Rest, Total + A + B).