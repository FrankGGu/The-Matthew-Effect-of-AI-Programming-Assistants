-module(solution).
-export([valid_tic_tac_toe/1]).

valid_tic_tac_toe(Board) ->
    XCount = count_cells(Board, $x),
    OCount = count_cells(Board, $o),
    case XCount < OCount of
        true -> false;
        _ -> 
            case XCount > OCount + 1 of
                true -> false;
                _ -> 
                    case is_winning(Board, $o) of
                        true -> OCount == XCount;
                        _ -> 
                            case is_winning(Board, $x) of
                                true -> XCount == OCount + 1;
                                _ -> true
                            end
                    end
            end
    end.

count_cells([], _) -> 0;
count_cells([H | T], C) ->
    Count = if H == C -> 1; true -> 0 end,
    Count + count_cells(T, C).

is_winning(Board, Player) ->
    Lines = [
        [hd(Board), hd(tl(Board)), hd(tl(tl(Board)))],
        [hd(tl(Board)), hd(tl(tl(Board))), hd(tl(tl(tl(Board))))],
        [hd(tl(tl(Board))), hd(tl(tl(tl(Board)))), hd(tl(tl(tl(tl(Board)))))],
        [hd(Board), hd(tl(tl(Board))), hd(tl(tl(tl(tl(Board))))),
        [hd(tl(Board)), hd(tl(tl(tl(Board)))), hd(tl(tl(tl(tl(tl(Board)))))),
        [hd(tl(tl(Board))), hd(tl(tl(tl(tl(Board)))), hd(tl(tl(tl(tl(tl(tl(Board)))))),
        [hd(Board), hd(tl(tl(Board))), hd(tl(tl(tl(tl(Board))))),
        [hd(tl(Board)), hd(tl(tl(tl(Board)))), hd(tl(tl(tl(tl(tl(Board))))))
    ],
    lists:any(fun(Line) -> all_equal(Line, Player) end, Lines).

all_equal([], _) -> true;
all_equal([H | T], P) ->
    H == P andalso all_equal(T, P).