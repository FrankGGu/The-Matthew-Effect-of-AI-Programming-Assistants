-spec closest_to_target(Arr :: [integer()], Target :: integer()) -> integer().
closest_to_target(Arr, Target) ->
    N = length(Arr),
    MinDiff = infinity,
    lists:foldl(fun(I, Acc) ->
        Current = lists:nth(I, Arr),
        lists:foldl(fun(J, {Min, CurrentAnd}) ->
            NewAnd = CurrentAnd band lists:nth(J, Arr),
            Diff = abs(NewAnd - Target),
            if 
                Diff < Min -> {Diff, NewAnd};
                true -> {Min, NewAnd}
            end
        end, Acc, lists:seq(I, N))
    end, {abs(hd(Arr) - Target), hd(Arr)}, lists:seq(1, N)),
    element(1, lists:foldl(fun(I, {MinDiff, _}) ->
        Current = lists:nth(I, Arr),
        lists:foldl(fun(J, {CurrentMin, CurrentAnd}) ->
            NewAnd = CurrentAnd band lists:nth(J, Arr),
            Diff = abs(NewAnd - Target),
            if 
                Diff < CurrentMin -> {Diff, NewAnd};
                true -> {CurrentMin, NewAnd}
            end
        end, {MinDiff, Current}, lists:seq(I, N))
    end, {abs(hd(Arr) - Target), hd(Arr)}, lists:seq(1, N))).