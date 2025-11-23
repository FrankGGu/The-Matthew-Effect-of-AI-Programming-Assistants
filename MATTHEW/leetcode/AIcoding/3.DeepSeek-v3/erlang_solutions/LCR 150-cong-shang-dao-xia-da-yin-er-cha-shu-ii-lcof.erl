-spec decorate_record(Tree :: #{} | null) -> [[integer()]].
decorate_record(Tree) ->
    case Tree of
        null -> [];
        _ -> decorate_record([Tree], [])
    end.

decorate_record([], Acc) ->
    lists:reverse(Acc);
decorate_record(Queue, Acc) ->
    {Level, NextQueue} = lists:foldl(
        fun(Node, {CurrentLevel, NextQ}) ->
            case Node of
                #{left := Left, right := Right, val := Val} ->
                    {CurrentLevel ++ [Val], NextQ ++ [Left, Right]};
                #{left := Left, val := Val} ->
                    {CurrentLevel ++ [Val], NextQ ++ [Left]};
                #{right := Right, val := Val} ->
                    {CurrentLevel ++ [Val], NextQ ++ [Right]};
                #{val := Val} ->
                    {CurrentLevel ++ [Val], NextQ}
            end
        end,
        {[], []},
        Queue
    ),
    case Level of
        [] -> lists:reverse(Acc);
        _ -> decorate_record([Node || Node <- NextQueue, Node =/= null], [Level | Acc])
    end.