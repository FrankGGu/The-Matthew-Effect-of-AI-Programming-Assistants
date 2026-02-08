-spec restore_string(S :: unicode:unicode_binary(), Indices :: [integer()]) -> unicode:unicode_binary().
restore_string(S, Indices) ->
    List = unicode:characters_to_list(S),
    Zipped = lists:zip(Indices, List),
    Sorted = lists:keysort(1, Zipped),
    Result = [Char || {_Index, Char} <- Sorted],
    unicode:characters_to_binary(Result).