-spec find_stable_mountains(Heights :: [integer()]) -> [[integer()]].
find_stable_mountains(Heights) ->
    N = length(Heights),
    if N < 3 -> [];
    true ->
        find_stable_mountains(Heights, 0, N-1, [])
    end.

find_stable_mountains(Heights, I, N, Acc) when I >= N - 1 ->
    lists:reverse(Acc);
find_stable_mountains(Heights, I, N, Acc) ->
    Peak = find_peak(Heights, I, N),
    if Peak =:= -1 ->
        find_stable_mountains(Heights, I+1, N, Acc);
    true ->
        Left = find_left_base(Heights, Peak),
        Right = find_right_base(Heights, Peak, N),
        if (Peak - Left >= 1) and (Right - Peak >= 1) ->
            NewAcc = [[Left, Right] | Acc],
            find_stable_mountains(Heights, Right, N, NewAcc);
        true ->
            find_stable_mountains(Heights, I+1, N, Acc)
        end
    end.

find_peak(Heights, I, N) ->
    if I + 1 >= N -> -1;
    true ->
        case (lists:nth(I+1, Heights) > lists:nth(I, Heights)) andalso
             (lists:nth(I+1, Heights) > lists:nth(I+2, Heights)) of
            true -> I+1;
            false -> find_peak(Heights, I+1, N)
        end
    end.

find_left_base(Heights, Peak) ->
    find_left_base(Heights, Peak-1, lists:nth(Peak, Heights)).

find_left_base(Heights, I, PeakHeight) ->
    if I < 1 -> 0;
    true ->
        Current = lists:nth(I, Heights),
        if Current >= PeakHeight -> I;
        true -> find_left_base(Heights, I-1, PeakHeight)
        end
    end.

find_right_base(Heights, Peak, N) ->
    find_right_base(Heights, Peak+1, lists:nth(Peak, Heights), N).

find_right_base(Heights, I, PeakHeight, N) ->
    if I >= N -> N-1;
    true ->
        Current = lists:nth(I, Heights),
        if Current >= PeakHeight -> I;
        true -> find_right_base(Heights, I+1, PeakHeight, N)
        end
    end.