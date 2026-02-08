-module(solution).
-export([is_valid_mountain/1]).

-spec is_valid_mountain(Arr :: [integer()]) -> boolean().
is_valid_mountain(Arr) ->
    if
        length(Arr) < 3 ->
            false;
        true ->
            check_mountain(Arr, true, false)
    end.

check_mountain([_], false, true) -> true;
check_mountain([_], _, _) -> false;

check_mountain([H1, H2 | T], true, HasClimbed) ->
    if
        H1 < H2 ->
            check_mountain([H2 | T], true, true);
        H1 == H2 ->
            false;
        H1 > H2 ->
            if
                HasClimbed ->
                    check_mountain([H2 | T], false, true);
                true ->
                    false
            end
    end;

check_mountain([H1, H2 | T], false, true) ->
    if
        H1 > H2 ->
            check_mountain([H2 | T], false, true);
        true ->
            false
    end;

check_mountain(_, _, _) -> false.