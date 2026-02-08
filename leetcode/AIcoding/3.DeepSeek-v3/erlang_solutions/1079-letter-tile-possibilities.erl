-spec num_tile_possibilities(Tiles :: unicode:unicode_binary()) -> integer().
num_tile_possibilities(Tiles) ->
    Counts = lists:foldl(fun(C, Acc) -> 
                            maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) 
                         end, #{}, unicode:characters_to_list(Tiles)),
    dfs(Counts).

dfs(Counts) ->
    maps:fold(fun(_, 0, Acc) -> Acc;
                 (C, V, Acc) ->
                     NewCounts = maps:update(C, V - 1, Counts),
                     Acc + 1 + dfs(NewCounts)
              end, 0, Counts).