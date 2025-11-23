-spec maximum_value(integer()) -> integer().
maximum_value(N) ->
    maximum_value(N, 0, 0, 0).

-spec maximum_value(integer(), integer(), integer(), integer()) -> integer().
maximum_value(0, Max, _, _) ->
    Max;
maximum_value(N, Max, Prev, PrevPrev) ->
    Current = N rem 10,
    NewMax = case Current =/= Prev andalso Current =/= PrevPrev of
        true -> max(Max, Current + Prev + PrevPrev);
        false -> Max
    end,
    maximum_value(N div 10, NewMax, Current, Prev).