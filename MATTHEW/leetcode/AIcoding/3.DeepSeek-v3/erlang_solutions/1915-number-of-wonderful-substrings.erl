-spec wonderful_substrings(Word :: unicode:unicode_binary()) -> integer().
wonderful_substrings(Word) ->
    Bin = unicode:characters_to_list(Word),
    Prefix = 0,
    Count = #{0 => 1},
    Result = 0,
    wonderful_substrings(Bin, Prefix, Count, Result).

wonderful_substrings([], _Prefix, _Count, Result) ->
    Result;
wonderful_substrings([C | Rest], Prefix, Count, Result) ->
    NewPrefix = Prefix bxor (1 bsl (C - $a)),
    NewResult = Result + maps:get(NewPrefix, Count, 0),
    F = fun(Shift) ->
            TmpPrefix = NewPrefix bxor (1 bsl Shift),
            NewResult + maps:get(TmpPrefix, Count, 0)
        end,
    FinalResult = lists:foldl(F, NewResult, lists:seq(0, 9)),
    NewCount = maps:update_with(NewPrefix, fun(V) -> V + 1 end, 1, Count),
    wonderful_substrings(Rest, NewPrefix, NewCount, FinalResult).