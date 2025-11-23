-spec max_depth_after_split(Seq :: unicode:unicode_binary()) -> [integer()].
max_depth_after_split(Seq) ->
    {_, Res} = lists:foldl(fun
        ($(, {Depth, Acc}) -> {Depth + 1, [Depth rem 2 | Acc]};
        ($), {Depth, Acc}) -> {Depth - 1, [(Depth - 1) rem 2 | Acc]}
    end, {0, []}, binary_to_list(Seq)),
    lists:reverse(Res).