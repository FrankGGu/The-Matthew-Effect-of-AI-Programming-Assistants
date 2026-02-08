-spec is_ugly(N :: integer()) -> boolean().
is_ugly(N) when N =< 0 -> false;
is_ugly(N) ->
    lists:foldl(fun(D, Acc) -> divide(Acc, D) end, N, [2, 3, 5]) =:= 1.

divide(N, D) ->
    case N rem D of
        0 -> divide(N div D, D);
        _ -> N
    end.