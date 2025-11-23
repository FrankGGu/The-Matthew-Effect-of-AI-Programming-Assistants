-spec max_score(S :: unicode:unicode_binary()) -> integer().
max_score(S) ->
    Bin = unicode:characters_to_binary(S),
    Size = byte_size(Bin),
    Left0 = 0,
    Right1 = lists:sum([1 || <<C:8>> <= Bin, C =:= $1]),
    max_score(Bin, 1, Left0, Right1, Right1).

max_score(_, Size, _, _, Max) when Size =:= 0 -> Max;
max_score(Bin, Pos, Left, Right, Max) when Pos < byte_size(Bin) ->
    <<_:Pos/binary, C:8, _/binary>> = Bin,
    NewLeft = Left + (if C =:= $0 -> 1; true -> 0 end),
    NewRight = Right - (if C =:= $1 -> 1; true -> 0 end),
    Current = NewLeft + NewRight,
    NewMax = max(Max, Current),
    max_score(Bin, Pos + 1, NewLeft, NewRight, NewMax);
max_score(_, _, _, _, Max) -> Max.