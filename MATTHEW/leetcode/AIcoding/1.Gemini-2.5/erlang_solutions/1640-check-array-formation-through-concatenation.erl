-module(solution).
-export([can_form_array/2]).

can_form_array(Arr, Pieces) ->
    PieceMap = lists:foldl(
        fun([H|_]=P, Acc) -> maps:put(H, P, Acc) end,
        #{},
        Pieces
    ),
    check_formation_recursive(Arr, PieceMap).

check_formation_recursive([], _PieceMap) ->
    true;
check_formation_recursive([H|_]=CurrentArr, PieceMap) ->
    case maps:is_key(H, PieceMap) of
        true ->
            Piece = maps:get(H, PieceMap),
            PieceLen = length(Piece),
            Prefix = lists:sublist(CurrentArr, PieceLen),
            if
                Prefix == Piece ->
                    RemainingArr = lists:nthtail(PieceLen, CurrentArr),
                    check_formation_recursive(RemainingArr, PieceMap);
                true ->
                    false
            end;
        false ->
            false
    end.