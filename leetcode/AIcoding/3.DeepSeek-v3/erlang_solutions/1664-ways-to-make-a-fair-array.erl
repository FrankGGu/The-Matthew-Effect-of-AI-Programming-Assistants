-spec ways_to_make_fair(Nums :: [integer()]) -> integer().
ways_to_make_fair(Nums) ->
    {LeftEven, LeftOdd} = {0, 0},
    {RightEven, RightOdd} = lists:foldl(fun(X, {E, O}) -> 
        case O of
            0 -> {E + X, O};
            _ -> {E, O + X}
        end
    end, {0, 0}, Nums),
    ways_to_make_fair(Nums, 0, LeftEven, LeftOdd, RightEven, RightOdd, 0).

ways_to_make_fair([], _Index, _LeftEven, _LeftOdd, _RightEven, _RightOdd, Count) -> Count;
ways_to_make_fair([X | Rest], Index, LeftEven, LeftOdd, RightEven, RightOdd, Count) ->
    NewCount = case Index rem 2 of
        0 -> 
            NewRightEven = RightEven - X,
            case LeftEven + NewRightEven =:= LeftOdd + RightOdd of
                true -> Count + 1;
                false -> Count
            end;
        _ -> 
            NewRightOdd = RightOdd - X,
            case LeftEven + RightOdd =:= LeftOdd + NewRightOdd of
                true -> Count + 1;
                false -> Count
            end
    end,
    {NewLeftEven, NewLeftOdd} = case Index rem 2 of
        0 -> {LeftEven + X, LeftOdd};
        _ -> {LeftEven, LeftOdd + X}
    end,
    ways_to_make_fair(Rest, Index + 1, NewLeftEven, NewLeftOdd, RightEven, RightOdd, NewCount).