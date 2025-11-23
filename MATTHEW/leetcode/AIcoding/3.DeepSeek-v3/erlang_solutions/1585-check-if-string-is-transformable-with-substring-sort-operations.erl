-spec is_transformable(S :: unicode:unicode_binary(), T :: unicode:unicode_binary()) -> boolean().
is_transformable(S, T) ->
    SList = binary_to_list(S),
    TList = binary_to_list(T),
    case length(SList) =:= length(TList) of
        false -> false;
        true ->
            check_transformable(SList, TList)
    end.

check_transformable(S, T) ->
    Positions = lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(List) -> List ++ [length(Acc)] end, [length(Acc)], Acc)
    end, #{}, S),
    lists:all(fun({Char, PosList}) ->
        lists:all(fun(Pos) ->
            lists:all(fun(PrevChar) ->
                PrevChar >= Char
            end, lists:sublist(S, 1, Pos))
        end, PosList)
    end, lists:zip(T, lists:seq(0, length(T) - 1))).