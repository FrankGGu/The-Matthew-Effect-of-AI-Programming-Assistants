-module(solution).
-export([winnerOfGame/1]).

winnerOfGame(Colors) ->
    case Colors of
        [] -> false;
        _ ->
            Chars = string:to_list(Colors),
            [FirstChar | Rest] = Chars,
            {AliceMoves, BobMoves} = count_moves(Rest, FirstChar, 1, 0, 0),
            AliceMoves > BobMoves
    end.

count_moves([], CurrentChar, CurrentCount, AliceAcc, BobAcc) ->
    update_moves(CurrentChar, CurrentCount, AliceAcc, BobAcc);
count_moves([H | T], CurrentChar, CurrentCount, AliceAcc, BobAcc) ->
    if
        H == CurrentChar ->
            count_moves(T, CurrentChar, CurrentCount + 1, AliceAcc, BobAcc);
        true ->
            {NewAliceAcc, NewBobAcc} = update_moves(CurrentChar, CurrentCount, AliceAcc, BobAcc),
            count_moves(T, H, 1, NewAliceAcc, NewBobAcc)
    end.

update_moves(CurrentChar, CurrentCount, AliceAcc, BobAcc) ->
    if
        CurrentCount >= 3 ->
            Moves = CurrentCount - 2,
            if
                CurrentChar == $A -> {AliceAcc + Moves, BobAcc};
                CurrentChar == $B -> {AliceAcc, BobAcc + Moves}
            end;
        true ->
            {AliceAcc, BobAcc}
    end.