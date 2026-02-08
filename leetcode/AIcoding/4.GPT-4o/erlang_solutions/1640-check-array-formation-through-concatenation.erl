-module(solution).
-export([can_form_array/2]).

can_form_array(A, pieces) ->
    can_form_array_helper(A, pieces, []).

can_form_array_helper([], [], _) -> 
    true;
can_form_array_helper([], _Pieces, _Visited) -> 
    false;
can_form_array_helper(A, Pieces, Visited) ->
    case find_piece(A, Pieces, Visited) of
        {ok, Piece, RemainingA} ->
            can_form_array_helper(RemainingA, Pieces, [Piece | Visited]);
        error -> 
            false
    end.

find_piece([], _Pieces, _Visited) -> 
    error;
find_piece(A, [Piece | RestPieces], Visited) ->
    case piece_matches(A, Piece) of
        true -> 
            {ok, Piece, tl(A)};
        false -> 
            find_piece(A, RestPieces, Visited)
    end.

piece_matches(A, Piece) ->
    lists:prefix(A, Piece) andalso lists:equal(Piece, lists:sublist(A, length(Piece))).