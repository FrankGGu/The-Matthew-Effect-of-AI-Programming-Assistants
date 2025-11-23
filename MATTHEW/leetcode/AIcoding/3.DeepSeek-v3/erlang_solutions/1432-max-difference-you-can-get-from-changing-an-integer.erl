-spec max_diff(N :: integer()) -> integer().
max_diff(N) ->
    S = integer_to_list(N),
    Len = length(S),
    Max = case lists:keyfind($9, 1, lists:zip(S, lists:seq(1, Len))) of
        false -> N;
        {_, Pos} -> 
            list_to_integer(replace(S, lists:nth(Pos, S), $9))
    end,
    Min = case lists:keyfind($1, 1, lists:zip(S, lists:seq(1, Len))) of
        false when hd(S) =/= $1 -> 
            list_to_integer(replace(S, hd(S), $1));
        {_, 1} -> 
            case lists:keyfind($0, 1, lists:zip(tl(S), lists:seq(2, Len))) of
                false -> N;
                {Val, Pos0} -> 
                    list_to_integer(replace(S, Val, $0))
            end;
        {_, Pos1} -> 
            list_to_integer(replace(S, lists:nth(Pos1, S), $0))
    end,
    Max - Min.

replace(S, Old, New) ->
    lists:map(fun(C) -> if C =:= Old -> New; true -> C end end, S).