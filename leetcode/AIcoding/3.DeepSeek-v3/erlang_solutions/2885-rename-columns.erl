-spec rename_columns(Data :: [[unicode:unicode_binary()]], Names :: [unicode:unicode_binary()]) -> [[unicode:unicode_binary()]].
rename_columns(Data, Names) ->
    case Data of
        [] -> [];
        [Header | Rows] -> [Names | Rows]
    end.