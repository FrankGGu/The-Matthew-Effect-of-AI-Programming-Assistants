-spec min_moves_to_make_palindrome(S :: unicode:unicode_binary()) -> integer().
min_moves_to_make_palindrome(S) ->
    min_moves_to_make_palindrome(binary_to_list(S), 0).

min_moves_to_make_palindrome([], Moves) -> Moves;
min_moves_to_make_palindrome([H|T], Moves) ->
    case lists:last(T) of
        H ->
            min_moves_to_make_palindrome(lists:droplast(T), Moves);
        _ ->
            {Pos, _} = lists:foldl(fun(Char, {Index, LastPos}) ->
                case Char =:= H of
                    true -> {Index + 1, Index};
                    false -> {Index + 1, LastPos}
                end
            end, {0, -1}, T),
            case Pos =:= -1 of
                true -> Moves + length(T) div 2;
                false ->
                    NewT = lists:append(lists:sublist(T, 1, Pos), lists:sublist(T, Pos + 2, length(T) - Pos - 1)),
                    min_moves_to_make_palindrome([H|NewT], Moves + length(T) - Pos - 1)
            )
        end
    end.