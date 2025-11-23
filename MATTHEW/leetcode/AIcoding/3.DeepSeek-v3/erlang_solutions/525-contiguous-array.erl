-spec find_max_length(Nums :: [integer()]) -> integer().
find_max_length(Nums) ->
    Map = #{0 => -1},
    {MaxLen, Sum, _} = lists:foldl(fun(N, {CurrentMax, CurrentSum, CurrentMap}) ->
        NewSum = CurrentSum + case N of 1 -> 1; 0 -> -1 end,
        case maps:find(NewSum, CurrentMap) of
            {ok, Index} -> {max(CurrentMax, erlang:element(1, erlang:now()) - Index), NewSum, CurrentMap};
            error -> {CurrentMax, NewSum, CurrentMap#{NewSum => erlang:element(1, erlang:now())}}
        end
    end, {0, 0, Map}, Nums),
    MaxLen.