-spec maximize_the_profit(N :: integer(), Offers :: [[integer()]]) -> integer().
maximize_the_profit(N, Offers) ->
    SortedOffers = lists:sort(fun([_, A, _], [_, B, _]) -> A =< B end, Offers),
    DP = array:new(N + 1, {default, 0}),
    {_, DP1} = lists:foldl(fun([Start, End, Gold], {J, DPAcc}) ->
        NewJ = End + 1,
        case NewJ =< N of
            true ->
                MaxPrev = array:get(Start, DPAcc),
                NewVal = MaxPrev + Gold,
                CurrentVal = array:get(NewJ, DPAcc),
                UpdatedVal = max(CurrentVal, NewVal),
                {NewJ, array:set(NewJ, UpdatedVal, DPAcc)};
            false ->
                {J, DPAcc}
        end
    end, {0, DP}, SortedOffers),
    array:get(N, DP1).