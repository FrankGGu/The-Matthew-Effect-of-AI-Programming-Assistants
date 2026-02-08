-spec two_sum(Nums :: [integer()], Target :: integer()) -> [integer()].
two_sum(Nums, Target) ->
    Map = maps:new(),
    two_sum(Nums, Target, 0, Map).

two_sum([Num | Rest], Target, Index, Map) ->
    case maps:find(Target - Num, Map) of
        {ok, FoundIndex} ->
            [FoundIndex, Index];
        error ->
            two_sum(Rest, Target, Index + 1, maps:put(Num, Index, Map))
    end;
two_sum([], _, _, _) ->
    [].