-spec min_subarray(Nums :: [integer()], P :: integer()) -> integer().
min_subarray(Nums, P) ->
    Total = lists:sum(Nums),
    Rem = Total rem P,
    if
        Rem =:= 0 -> 0;
        true ->
            Prefix = 0,
            Map = #{0 => -1},
            {MinLen, _} = lists:foldl(fun(Num, {Min, {Sum, M}}) ->
                NewSum = (Sum + Num) rem P,
                Target = (NewSum - Rem) rem P,
                case maps:find(Target, M) of
                    {ok, Index} ->
                        {min(Min, Index - maps:get(Target, M)), {NewSum, maps:put(NewSum, Index, M)}};
                    error ->
                        {Min, {NewSum, maps:put(NewSum, Index, M)}}
                end
            end, {length(Nums), {Prefix, Map}}, lists:zip(Nums, lists:seq(0, length(Nums) - 1))),
            if
                MinLen =:= length(Nums) -> -1;
                true -> MinLen
            end
    end.