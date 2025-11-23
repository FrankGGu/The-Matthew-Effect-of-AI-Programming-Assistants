-spec convert(S :: unicode:unicode_binary(), NumRows :: integer()) -> unicode:unicode_binary().
convert(S, NumRows) ->
    convert(S, NumRows, 0, []).

convert([], _, _, Acc) -> 
    lists:flatten(Acc);
convert([Char | Tail], 1, _Count, Acc) ->
    convert(Tail, 1, 1, [Char | Acc]);
convert([Char | Tail], NumRows, Count, Acc) when Count < NumRows ->
    convert(Tail, NumRows, Count + 1, [Char | Acc]);
convert([Char | Tail], NumRows, NumRows, Acc) ->
    convert(Tail, NumRows, 1, [Char | Acc]).
