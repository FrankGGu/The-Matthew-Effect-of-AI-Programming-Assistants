-module(solution).
-export([remove_colored_pieces/2]).

remove_colored_pieces(Pieces, Colors) ->
    remove_colored_pieces_helper(Pieces, Colors, []).

remove_colored_pieces_helper([], _, _) -> 
    true;
remove_colored_pieces_helper([H | T], Colors, History) ->
    case History of
        [] -> remove_colored_pieces_helper(T, Colors, [H]);
        [Prev] when Prev == H -> 
            remove_colored_pieces_helper(T, Colors, History);
        _ -> 
            remove_colored_pieces_helper(T, Colors, [H | History])
    end.

main() ->
    Pieces = "AAABABBA",
    Colors = "AB",
    io:format("Result: ~p~n", [remove_colored_pieces(Pieces, Colors)]).