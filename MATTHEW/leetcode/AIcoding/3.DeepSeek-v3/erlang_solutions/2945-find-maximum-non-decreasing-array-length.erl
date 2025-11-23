-spec max_non_decreasing_length(Nums :: [integer()]) -> integer().
max_non_decreasing_length(Nums) ->
    case Nums of
        [] -> 0;
        _ ->
            lists:foldl(fun(_, {Prev, MaxLen, CurrentLen}) when Prev =:= undefined ->
                                {undefined, 1, 1};
                            (Num, {Prev, MaxLen, CurrentLen}) when Num >= Prev ->
                                NewCurrentLen = CurrentLen + 1,
                                NewMaxLen = max(MaxLen, NewCurrentLen),
                                {Num, NewMaxLen, NewCurrentLen};
                            (Num, {Prev, MaxLen, CurrentLen}) ->
                                NewCurrentLen = 1,
                                NewMaxLen = max(MaxLen, NewCurrentLen),
                                {Num, NewMaxLen, NewCurrentLen}
                         end, {undefined, 0, 0}, Nums),
            element(2, lists:foldl(fun(_, {Prev, MaxLen, CurrentLen}) when Prev =:= undefined ->
                                {undefined, 1, 1};
                            (Num, {Prev, MaxLen, CurrentLen}) when Num >= Prev ->
                                NewCurrentLen = CurrentLen + 1,
                                NewMaxLen = max(MaxLen, NewCurrentLen),
                                {Num, NewMaxLen, NewCurrentLen};
                            (Num, {Prev, MaxLen, CurrentLen}) ->
                                NewCurrentLen = 1,
                                NewMaxLen = max(MaxLen, NewCurrentLen),
                                {Num, NewMaxLen, NewCurrentLen}
                         end, {undefined, 0, 0}, Nums))
    end.