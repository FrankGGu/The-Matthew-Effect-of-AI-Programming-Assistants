-spec two_sum(Nums :: [integer()], Target :: integer()) -> [integer()].
two_sum(Nums, Target) ->
    two_sum(Nums, Target, 0, []).

two_sum([], _, _, _) -> [];
two_sum([H | T], Target, Index, Acc) ->
    case lists:member(Target - H, T) of
        true -> [Index, lists:index(Target - H, T) + Index + 1];
        false -> two_sum(T, Target, Index + 1, Acc)
    end.
