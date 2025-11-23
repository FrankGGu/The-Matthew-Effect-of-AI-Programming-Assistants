-module(k_highest_ranked_items_within_a_price_range).
-export([highestRankedKItems/2]).

highestRankedKItems(Grid, PriceRange) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Items = collect_items(Grid, PriceRange, 0, 0, []),
    Sorted = lists:sort(fun(A, B) -> 
        if 
            element(1, A) /= element(1, B) -> element(1, A) < element(1, B);
            true -> 
                if 
                    element(2, A) /= element(2, B) -> element(2, A) < element(2, B);
                    true -> element(3, A) < element(3, B)
                end
        end
    end, Items),
    take_k(Sorted, 0, []).

collect_items(_, _, R, C, Acc) when R >= length(Grid) -> Acc;
collect_items(Grid, PriceRange, R, C, Acc) ->
    case C >= length(hd(Grid)) of
        true -> collect_items(Grid, PriceRange, R+1, 0, Acc);
        false ->
            Value = lists:nth(C+1, lists:nth(R+1, Grid)),
            case Value >= element(1, PriceRange) andalso Value =< element(2, PriceRange) of
                true -> collect_items(Grid, PriceRange, R, C+1, [{Value, R, C} | Acc]);
                false -> collect_items(Grid, PriceRange, R, C+1, Acc)
            end
    end.

take_k(_, _, Acc) when length(Acc) >= 5 -> Acc;
take_k([], _, Acc) -> Acc;
take_k([H | T], I, Acc) ->
    take_k(T, I+1, [H | Acc]).

highestRankedKItems(Grid, PriceRange) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Items = collect_items(Grid, PriceRange, 0, 0, []),
    Sorted = lists:sort(fun(A, B) -> 
        if 
            element(1, A) /= element(1, B) -> element(1, A) < element(1, B);
            true -> 
                if 
                    element(2, A) /= element(2, B) -> element(2, A) < element(2, B);
                    true -> element(3, A) < element(3, B)
                end
        end
    end, Items),
    take_k(Sorted, 0, []).