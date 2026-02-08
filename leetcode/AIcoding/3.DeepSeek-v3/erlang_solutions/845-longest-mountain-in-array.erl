-spec longest_mountain(Arr :: [integer()]) -> integer().
longest_mountain(Arr) ->
    N = length(Arr),
    if N < 3 -> 0;
       true ->
            Up = lists:duplicate(N, 0),
            Down = lists:duplicate(N, 0),
            {Up1, _} = lists:foldl(fun(I, {U, _}) ->
                case I > 1 andalso lists:nth(I, Arr) > lists:nth(I - 1, Arr) of
                    true -> {setelement(I, U, element(I - 1, U) + 1}, {setelement(I, U, element(I - 1, U) + 1}, I};
                    false -> {U, I}
                end
            end, {list_to_tuple(Up), 1}, lists:seq(2, N)),
            {Down1, _} = lists:foldr(fun(I, {D, _}) ->
                case I < N andalso lists:nth(I, Arr) > lists:nth(I + 1, Arr) of
                    true -> {setelement(I, D, element(I + 1, D) + 1}, {setelement(I, D, element(I + 1, D) + 1}, I};
                    false -> {D, I}
                end
            end, {list_to_tuple(Down), N}, lists:seq(N - 1, 1, -1)),
            Max = lists:foldl(fun(I, Acc) ->
                UpVal = element(I, Up1),
                DownVal = element(I, Down1),
                if UpVal > 0 andalso DownVal > 0 ->
                    max(Acc, UpVal + DownVal + 1);
                   true -> Acc
                end
            end, 0, lists:seq(1, N)),
            if Max >= 3 -> Max;
               true -> 0
            end
    end.