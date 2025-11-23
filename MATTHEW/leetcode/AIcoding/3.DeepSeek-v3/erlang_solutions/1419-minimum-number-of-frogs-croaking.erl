-spec min_number_of_frogs(CroakOfFrogs :: unicode:unicode_binary()) -> integer().
min_number_of_frogs(CroakOfFrogs) ->
    Counts = #{$c => 0, $r => 0, $o => 0, $a => 0, $k => 0},
    ActiveFrogs = 0,
    MaxFrogs = 0,
    min_number_of_frogs_helper(CroakOfFrogs, Counts, ActiveFrogs, MaxFrogs).

min_number_of_frogs_helper(<<>>, #{ $c := C, $r := R, $o := O, $a := A, $k := K }, ActiveFrogs, MaxFrogs) ->
    case {C, R, O, A, K} of
        {0, 0, 0, 0, 0} -> MaxFrogs;
        _ -> -1
    end;
min_number_of_frogs_helper(<<Char:8, Rest/binary>>, Counts, ActiveFrogs, MaxFrogs) ->
    NewCounts = maps:update_with(Char, fun(V) -> V + 1 end, Counts),
    case Char of
        $c ->
            NewActiveFrogs = ActiveFrogs + 1,
            NewMaxFrogs = max(MaxFrogs, NewActiveFrogs),
            min_number_of_frogs_helper(Rest, NewCounts, NewActiveFrogs, NewMaxFrogs);
        $k ->
            case maps:get($a, NewCounts) > 0 andalso
                 maps:get($o, NewCounts) > 0 andalso
                 maps:get($r, NewCounts) > 0 andalso
                 maps:get($c, NewCounts) > 0 of
                true ->
                    UpdatedCounts = maps:map(fun
                        (K, V) when K =:= $c; K =:= $r; K =:= $o; K =:= $a; K =:= $k -> V - 1;
                        (_, V) -> V
                    end, NewCounts),
                    min_number_of_frogs_helper(Rest, UpdatedCounts, ActiveFrogs - 1, MaxFrogs);
                false -> -1
            end;
        _ ->
            case check_counts(NewCounts) of
                true -> min_number_of_frogs_helper(Rest, NewCounts, ActiveFrogs, MaxFrogs);
                false -> -1
            end
    end.

check_counts(#{ $c := C, $r := R, $o := O, $a := A, $k := K }) ->
    C >= R andalso R >= O andalso O >= A andalso A >= K.