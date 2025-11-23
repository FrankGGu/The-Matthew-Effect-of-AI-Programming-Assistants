-spec can_be_increasing(Nums :: [integer()]) -> boolean().
can_be_increasing(Nums) ->
    case check(Nums, false) of
        true -> true;
        false -> false
    end.

check([_], _) -> true;
check([A, B | Rest], Removed) when A < B ->
    check([B | Rest], Removed);
check([A, B | Rest], false) ->
    check([A | Rest], true) orelse check([B | Rest], true);
check(_, _) -> false.