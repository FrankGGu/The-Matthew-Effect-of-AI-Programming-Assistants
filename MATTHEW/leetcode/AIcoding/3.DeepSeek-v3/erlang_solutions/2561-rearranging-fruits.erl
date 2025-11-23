-module(rearranging_fruits).
-export([min_cost/2]).

min_cost(Basket1, Basket2) ->
    Sum1 = lists:sum(Basket1),
    Sum2 = lists:sum(Basket2),
    case (Sum1 + Sum2) rem 2 of
        1 -> -1;
        0 ->
            Target = (Sum1 + Sum2) div 2,
            Diff1 = Target - Sum1,
            case Diff1 of
                0 -> 0;
                _ ->
                    Count1 = count_elements(Basket1),
                    Count2 = count_elements(Basket2),
                    Combined = maps:merge(fun(_, V1, V2) -> V1 + V2 end, Count1, Count2),
                    case check_possible(Combined) of
                        false -> -1;
                        true ->
                            {List1, List2} = get_swap_lists(Basket1, Basket2, Target),
                            calculate_min_cost(List1, List2)
                    end
            end
    end.

count_elements(List) ->
    count_elements(List, #{}).

count_elements([], Map) -> Map;
count_elements([H|T], Map) ->
    case maps:is_key(H, Map) of
        true -> count_elements(T, maps:update(H, maps:get(H, Map) + 1, Map));
        false -> count_elements(T, maps:put(H, 1, Map))
    end.

check_possible(CountMap) ->
    maps:fold(fun(_, V, Acc) ->
        case V rem 2 of
            0 -> Acc;
            1 -> false
        end andalso Acc
    end, true, CountMap).

get_swap_lists(Basket1, Basket2, Target) ->
    Sum1 = lists:sum(Basket1),
    {List1, List2} = if
        Sum1 < Target -> {Basket2, Basket1};
        true -> {Basket1, Basket2}
    end,
    Diff = abs(Target - Sum1) div 2,
    {List1, List2, Diff}.

calculate_min_cost(List1, List2) ->
    Sorted1 = lists:sort(List1),
    Sorted2 = lists:sort(List2),
    MinCost = calculate_min_cost(Sorted1, Sorted2, 0),
    MinCost.

calculate_min_cost([], [], Cost) -> Cost;
calculate_min_cost([H1|T1], [H2|T2], Cost) when H1 > H2 ->
    calculate_min_cost(T1, T2, Cost + min(H2, H1));
calculate_min_cost([_|T1], [_|T2], Cost) ->
    calculate_min_cost(T1, T2, Cost).