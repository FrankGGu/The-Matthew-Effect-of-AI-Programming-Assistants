-spec is_match(S :: unicode:unicode_binary(), P :: unicode:unicode_binary()) -> boolean().
is_match(S, P) ->
    is_match(S, P, 0, 0).

is_match([], [], _, _) -> true;
is_match(_, [], _, _) -> false;
is_match([], [_ | _], _, _) -> false;
is_match([SHead | STail], [PHead | PTail], SIdx, PIdx) when PHead =:= $? ->
    is_match(STail, PTail, SIdx + 1, PIdx + 1);
is_match([SHead | STail], [PHead | PTail], SIdx, PIdx) when PHead =:= $* ->
    is_match(STail, PTail, SIdx + 1, PIdx) orelse is_match([SHead | STail], PTail, SIdx + 1, PIdx);
is_match([SHead | STail], [PHead | PTail], SIdx, PIdx) when SHead =:= PHead ->
    is_match(STail, PTail, SIdx + 1, PIdx + 1);
is_match([_ | STail], [PHead | PTail], SIdx, PIdx) when PHead =:= $* ->
    is_match(STail, PTail, SIdx + 1, PIdx) orelse is_match([_ | STail], PTail, SIdx, PIdx + 1);
is_match(_, _, _, _) -> false.
