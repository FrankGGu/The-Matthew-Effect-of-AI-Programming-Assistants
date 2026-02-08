-spec find_anagrams(S :: binary(), P :: binary()) -> [integer()].
find_anagrams(S, P) ->
    PLen = byte_size(P),
    SLen = byte_size(S),
    PTbl = freq_table(P),
    find_anagrams(S, PTbl, PLen, SLen, 0, []).

freq_table(Str) ->
    freq_table(Str, 0, #{}, byte_size(Str)).

freq_table(_Str, Pos, Tbl, Len) when Pos == Len -> Tbl;
freq_table(Str, Pos, Tbl, Len) ->
    <<_:Pos/binary, C:8, _/binary>> = Str,
    NewTbl = maps:update_with(C, fun(X) -> X+1 end, 1, Tbl),
    freq_table(Str, Pos+1, NewTbl, Len).

find_anagrams(_S, _PTbl, PLen, SLen, I, Acc) when I > SLen - PLen ->
    lists:reverse(Acc);
find_anagrams(S, PTbl, PLen, SLen, I, Acc) ->
    <<_:I/binary, Window:PLen/binary, _/binary>> = S,
    case freq_table(Window) =:= PTbl of
        true -> find_anagrams(S, PTbl, PLen, SLen, I+1, [I|Acc]);
        false -> find_anagrams(S, PTbl, PLen, SLen, I+1, Acc)
    end.
