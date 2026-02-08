-spec max_number_of_balloons(Text :: unicode:unicode_binary()) -> integer().
max_number_of_balloons(Text) ->
    CharList = unicode:characters_to_list(Text),

    InitialCounts = #{'b' => 0, 'a' => 0, 'l' => 0, 'o' => 0, 'n' => 0},

    Counts = lists:foldl(
        fun(Char, Acc) ->
            case Char of
                $b -> maps:update_with($b, fun(N) -> N + 1 end, 1, Acc);
                $a -> maps:update_with($a, fun(N) -> N + 1 end, 1, Acc);
                $l -> maps:update_with($l, fun(N) -> N + 1 end, 1, Acc);
                $o -> maps:update_with($o, fun(N) -> N + 1 end, 1, Acc);
                $n -> maps:update_with($n, fun(N) -> N + 1 end, 1, Acc);
                _ -> Acc
            end
        end,
        InitialCounts,
        CharList
    ),

    B_count = maps:get($b, Counts, 0),
    A_count = maps:get($a, Counts, 0),
    L_count = maps:get($l, Counts, 0),
    O_count = maps:get($o, Counts, 0),
    N_count = maps:get($n, Counts, 0),

    B_balloons = B_count div 1,
    A_balloons = A_count div 1,
    L_balloons = L_count div 2,
    O_balloons = O_count div 2,
    N_balloons = N_count div 1,

    lists:min([B_balloons, A_balloons, L_balloons, O_balloons, N_balloons]).