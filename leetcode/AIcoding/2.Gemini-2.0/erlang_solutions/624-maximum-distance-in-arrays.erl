-module(maximum_distance).
-export([maximum_distance/1]).

maximum_distance(Arrays) ->
    {Min1, Max1} = lists:foldl(
        fun(Arr, {Min, Max}) ->
            [H | T] = Arr,
            NewMin = case Min of
                infinity -> H;
                _ -> min(Min, H)
            end,
            NewMax = case Max of
                -infinity -> lists:last(Arr);
                _ -> max(Max, lists:last(Arr))
            end,
            {NewMin, NewMax}
        end, {infinity, -infinity}, Arrays
    ),

    lists:foldl(
        fun(Arr, Acc) ->
            [H | T] = Arr,
            MaxDist1 = abs(lists:last(Arr) - Min1),
            MaxDist2 = abs(Max1 - H),

            Dist1 = case Min1 == H of
                true -> -infinity;
                false -> MaxDist1
            end,
            Dist2 = case Max1 == lists:last(Arr) of
                true -> -infinity;
                false -> MaxDist2
            end,

            max(Acc, max(Dist1, Dist2))
        end, 0, Arrays
    ).