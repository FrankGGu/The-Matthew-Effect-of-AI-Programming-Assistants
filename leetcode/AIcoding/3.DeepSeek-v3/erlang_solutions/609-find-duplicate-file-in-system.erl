-spec find_duplicate(Paths :: [unicode:unicode_binary()]) -> [[unicode:unicode_binary()]].
find_duplicate(Paths) ->
    ContentMap = lists:foldl(
        fun(Path, Acc) ->
            [Dir | Files] = binary:split(Path, <<" ">>, [global]),
            lists:foldl(
                fun(File, Acc1) ->
                    [Name, Content] = binary:split(File, <<"(">>),
                    Content1 = binary:part(Content, 0, byte_size(Content) - 1),
                    FullPath = <<Dir/binary, "/", Name/binary>>,
                    case maps:find(Content1, Acc1) of
                        {ok, List} -> maps:put(Content1, [FullPath | List], Acc1);
                        error -> maps:put(Content1, [FullPath], Acc1)
                    end
                end,
                Acc,
                Files
            )
        end,
        maps:new(),
        Paths
    ),
    lists:filtermap(
        fun({_, PathsList}) ->
            case length(PathsList) > 1 of
                true -> {true, PathsList};
                false -> false
            end
        end,
        maps:to_list(ContentMap)
    ).