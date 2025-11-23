-spec can_form_array(Arr :: [integer()], Pieces :: [[integer()]]) -> boolean().
can_form_array(Arr, Pieces) ->
    PieceMap = lists:foldl(fun(Piece, Acc) -> 
                               [{hd(Piece), Piece} | Acc] 
                           end, [], Pieces),
    can_form_array(Arr, PieceMap, []).

can_form_array([], _PieceMap, []) -> true;
can_form_array([], _PieceMap, _Acc) -> false;
can_form_array([H | T], PieceMap, Acc) ->
    case lists:keyfind(H, 1, PieceMap) of
        {H, Piece} ->
            case lists:prefix(Piece, [H | T]) of
                true ->
                    NewT = lists:nthtail(length(Piece), [H | T]),
                    can_form_array(NewT, PieceMap, []);
                false -> false
            end;
        false -> false
    end.