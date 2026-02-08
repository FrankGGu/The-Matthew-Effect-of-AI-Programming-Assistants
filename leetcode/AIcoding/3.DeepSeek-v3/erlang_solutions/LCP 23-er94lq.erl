-spec is_magic(:: [integer()]) -> boolean().
is_magic(Target) ->
    N = length(Target),
    case N of
        0 -> false;
        1 -> Target == [1];
        _ ->
            Perm = lists:seq(1, N),
            check_magic(Perm, Target, 0)
    end.

check_magic([], [], _) -> true;
check_magic(Perm, Target, K) ->
    case (K rem 2) of
        0 ->
            NewPerm = [X || X <- Perm, (X rem 2) == 1] ++ [X || X <- Perm, (X rem 2) == 0],
            case lists:sublist(NewPerm, length(Target)) == Target of
                true -> true;
                false -> check_magic(NewPerm, Target, K + 1)
            end;
        1 ->
            NewPerm = [X || X <- Perm, (X rem 2) == 0] ++ [X || X <- Perm, (X rem 2) == 1],
            case lists:sublist(NewPerm, length(Target)) == Target of
                true -> true;
                false -> check_magic(NewPerm, Target, K + 1)
            end
    end.