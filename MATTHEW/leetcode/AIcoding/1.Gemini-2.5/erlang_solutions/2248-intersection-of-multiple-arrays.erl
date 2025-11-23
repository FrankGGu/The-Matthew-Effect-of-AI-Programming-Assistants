-spec intersection(Nums :: [[integer()]]) -> [integer()].
intersection(Nums) ->
    case Nums of
        [] ->
            [];
        [H | T] ->
            InitialSet = sets:from_list(H),
            FinalSet = lists:foldl(fun(List, AccSet) ->
                                       sets:intersection(AccSet, sets:from_list(List))
                               end, InitialSet, T),
            lists:sort(sets:to_list(FinalSet))
    end.