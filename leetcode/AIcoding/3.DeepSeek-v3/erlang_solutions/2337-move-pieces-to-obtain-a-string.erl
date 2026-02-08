-spec can_change(Start :: unicode:unicode_binary(), Target :: unicode:unicode_binary()) -> boolean().
can_change(Start, Target) ->
    StartList = binary_to_list(Start),
    TargetList = binary_to_list(Target),
    case length(StartList) =:= length(TargetList) of
        false -> false;
        true -> check(StartList, TargetList)
    end.

check(Start, Target) ->
    S = lists:filter(fun(X) -> X =/= $_ end, Start),
    T = lists:filter(fun(X) -> X =/= $_ end, Target),
    case S =:= T of
        false -> false;
        true -> check_positions(Start, Target)
    end.

check_positions(Start, Target) ->
    {StartL, StartR} = lists:foldl(fun
        ($L, {LAcc, RAcc}) -> {LAcc ++ [$L], RAcc};
        ($R, {LAcc, RAcc}) -> {LAcc, RAcc ++ [$R]};
        (_, Acc) -> Acc
    end, {[], []}, Start),
    {TargetL, TargetR} = lists:foldl(fun
        ($L, {LAcc, RAcc}) -> {LAcc ++ [$L], RAcc};
        ($R, {LAcc, RAcc}) -> {LAcc, RAcc ++ [$R]};
        (_, Acc) -> Acc
    end, {[], []}, Target),
    check_lr(StartL, TargetL, fun(A, B) -> A >= B end) andalso
    check_lr(StartR, TargetR, fun(A, B) -> A =< B end).

check_lr(Start, Target, Compare) ->
    lists:all(fun({S, T}) -> Compare(S, T) end,
              lists:zipwith(fun(S, T) -> {S, T} end,
                           lists:map(fun pos/1, Start),
                           lists:map(fun pos/1, Target))).

pos(Char) ->
    case Char of
        $L -> -1;
        $R -> 1
    end.