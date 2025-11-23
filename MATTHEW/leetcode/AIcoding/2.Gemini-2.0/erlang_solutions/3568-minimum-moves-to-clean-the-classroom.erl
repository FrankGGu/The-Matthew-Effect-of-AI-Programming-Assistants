-module(min_moves_to_clean).
-export([min_moves/1]).

min_moves(classroom) ->
    N = length(classroom),
    clean_classroom(classroom, 0, N).

clean_classroom([], Moves, _N) ->
    Moves;
clean_classroom(Classroom, Moves, N) ->
    FirstDirty = find_first_dirty(Classroom),
    case FirstDirty of
        none ->
            Moves;
        _ ->
            NewMoves = Moves + 1,
            NewClassroom = toggle_region(Classroom, FirstDirty, N),
            clean_classroom(NewClassroom, NewMoves, N)
    end.

find_first_dirty([]) ->
    none;
find_first_dirty([0 | Rest]) ->
    find_first_dirty(Rest);
find_first_dirty([1 | _]) ->
    1.

toggle_region(Classroom, Start, N) ->
    toggle_region(Classroom, Start, N, []).

toggle_region([], _, _, Acc) ->
    lists:reverse(Acc);
toggle_region(Classroom, Start, N, Acc) ->
    Len = length(Classroom),
    End = min(Start + 2, Len + 1),
    NewClassroom = lists:sublist(Classroom, 1, Start - 1) ++
                   toggle_bits(lists:sublist(Classroom, Start, End - Start)) ++
                   lists:sublist(Classroom, End, Len - (End - 1)),
    NewClassroom.

toggle_bits([]) ->
    [];
toggle_bits([Bit | Rest]) ->
    NewBit = case Bit of
        0 -> 1;
        1 -> 0
    end,
    [NewBit | toggle_bits(Rest)].