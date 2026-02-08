-spec min_operations(Logs :: [unicode:unicode_binary()]) -> integer().
min_operations(Logs) ->
    lists:foldl(fun
        (<<"../">>, Depth) when Depth > 0 -> Depth - 1;
        (<<"./">>, Depth) -> Depth;
        (_, Depth) -> Depth + 1
    end, 0, Logs).