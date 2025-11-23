-spec adventure_camp(expeditions :: [unicode:unicode_binary()]) -> integer().
adventure_camp(Expeditions) ->
    case Expeditions of
        [] -> -1;
        _ ->
            Visited = sets:new(),
            {MaxCount, Res} = lists:foldl(
                fun(Expedition, {CurrentMax, CurrentIndex}) ->
                    case Expedition of
                        <<>> ->
                            {CurrentMax, CurrentIndex};
                        _ ->
                            Tokens = binary:split(Expedition, <<"->">>, [global, trim]),
                            NewVisited = lists:foldl(
                                fun(Token, Acc) ->
                                    sets:add_element(Token, Acc)
                                end,
                                Visited,
                                Tokens
                            ),
                            NewCount = sets:size(NewVisited) - sets:size(Visited),
                            if
                                NewCount > CurrentMax ->
                                    {NewCount, CurrentIndex + 1};
                                true ->
                                    {CurrentMax, CurrentIndex}
                            end
                    end
                end,
                {-1, -1},
                lists:droplast(Expeditions)
            ),
            if
                MaxCount > 0 -> Res;
                true -> -1
            end
    end.