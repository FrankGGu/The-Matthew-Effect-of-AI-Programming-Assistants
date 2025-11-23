-spec generate(NumRows :: integer()) -> [[integer()]].
generate(NumRows) ->
    generate(NumRows, []).

generate(0, Acc) ->
    lists:reverse(Acc);
generate(NumRows, Acc) ->
    case Acc of
        [] -> 
            generate(NumRows - 1, [[1] | Acc]);
        [Prev | _] ->
            NewRow = [1 | [lists:nth(I, Prev) + lists:nth(I + 1, Prev) || I <- lists:seq(1, length(Prev) - 1)]] ++ [1],
            generate(NumRows - 1, [NewRow | Acc])
    end.