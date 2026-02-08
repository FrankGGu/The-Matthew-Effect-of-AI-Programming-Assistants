-spec find_number_of_lis(Nums :: [integer()]) -> integer().
find_number_of_lis(Nums) ->
    N = length(Nums),
    if N == 0 -> 0;
       true ->
            Lengths = array:new([{size, N}, {default, 1}]),
            Counts = array:new([{size, N}, {default, 1}]),
            {MaxLen, Ans} = lists:foldl(fun(I, {MaxLen, Ans}) ->
                {LenI, CntI} = lists:foldl(fun(J, {Len, Cnt}) ->
                    if
                        lists:nth(J, Nums) < lists:nth(I, Nums) ->
                            LenJ = array:get(J, Lengths),
                            if
                                LenJ + 1 > Len -> {LenJ + 1, array:get(J, Counts)};
                                LenJ + 1 == Len -> {Len, Cnt + array:get(J, Counts)};
                                true -> {Len, Cnt}
                            end;
                        true -> {Len, Cnt}
                    end
                end, {1, 1}, lists:seq(1, I - 1)),
                Lengths1 = array:set(I, LenI, Lengths),
                Counts1 = array:set(I, CntI, Counts),
                if
                    LenI > MaxLen -> {LenI, CntI};
                    LenI == MaxLen -> {MaxLen, Ans + CntI};
                    true -> {MaxLen, Ans}
                end
            end, {1, 0}, lists:seq(1, N)),
            Ans
    end.