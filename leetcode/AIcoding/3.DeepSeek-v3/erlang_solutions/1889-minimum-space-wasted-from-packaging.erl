-module(solution).
-export([min_wasted_space/3]).

-spec min_wasted_space(Packages :: [integer()], Boxes :: [[integer()]], Suppliers :: [integer()]) -> integer().
min_wasted_space(Packages, Boxes, Suppliers) ->
    SortedPackages = lists:sort(Packages),
    Total = lists:sum(SortedPackages),
    MinWaste = lists:foldl(
        fun(Supplier, Acc) ->
            BoxList = lists:nth(Supplier + 1, Boxes),
            SortedBoxes = lists:sort(BoxList),
            case check_boxes(SortedPackages, SortedBoxes) of
                {ok, Waste} -> min(Acc, Waste - Total);
                error -> Acc
            end
        end,
        infinity,
        Suppliers
    ),
    case MinWaste of
        infinity -> -1;
        _ -> MinWaste rem 1000000007
    end.

check_boxes(Packages, Boxes) ->
    case lists:last(Boxes) < lists:last(Packages) of
        true -> error;
        false ->
            Waste = calculate_waste(Packages, Boxes, 0, 0),
            {ok, Waste}
    end.

calculate_waste([], _, _, Total) -> Total;
calculate_waste([P | Ps], Boxes, BoxIndex, Total) ->
    {NewBoxIndex, Box} = find_box(P, Boxes, BoxIndex),
    calculate_waste(Ps, Boxes, NewBoxIndex, Total + Box).

find_box(P, Boxes, Index) ->
    case Index < length(Boxes) of
        true ->
            Box = lists:nth(Index + 1, Boxes),
            case Box >= P of
                true -> {Index, Box};
                false -> find_box(P, Boxes, Index + 1)
            end;
        false ->
            Box = lists:last(Boxes),
            {length(Boxes) - 1, Box}
    end.