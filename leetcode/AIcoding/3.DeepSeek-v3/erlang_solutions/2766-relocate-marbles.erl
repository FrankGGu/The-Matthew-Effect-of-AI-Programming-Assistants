-spec relocate_marbles(Marbles :: [integer()], MoveFrom :: [integer()], MoveTo :: [integer()]) -> [integer()].
relocate_marbles(Marbles, MoveFrom, MoveTo) ->
    MarbleSet = sets:from_list(Marbles),
    UpdatedSet = lists:foldl(fun({From, To}, Acc) ->
                                    case sets:is_element(From, Acc) of
                                        true -> 
                                            Acc1 = sets:del_element(From, Acc),
                                            sets:add_element(To, Acc1);
                                        false -> Acc
                                    end
                            end, MarbleSet, lists:zip(MoveFrom, MoveTo)),
    lists:sort(sets:to_list(UpdatedSet)).