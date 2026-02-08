-spec max_distance(Colors :: [integer()]) -> integer().
max_distance(Colors) ->
    N = length(Colors),
    case N of
        0 -> 0;
        _ ->
            First = lists:nth(1, Colors),
            Last = lists:nth(N, Colors),
            if
                First =/= Last -> N - 1;
                true ->
                    Max1 = lists:max([I - 1 || I <- lists:seq(1, N), lists:nth(I, Colors) =/= Last]),
                    Max2 = lists:max([N - I || I <- lists:seq(1, N), lists:nth(I, Colors) =/= First]),
                    max(Max1, Max2)
            end
    end.