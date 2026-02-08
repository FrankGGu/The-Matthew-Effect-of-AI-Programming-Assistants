-spec is_it_possible(Word1 :: unicode:unicode_binary(), Word2 :: unicode:unicode_binary()) -> boolean().
is_it_possible(Word1, Word2) ->
    Freq1 = count_freq(Word1),
    Freq2 = count_freq(Word2),
    Keys1 = maps:keys(Freq1),
    Keys2 = maps:keys(Freq2),
    lists:any(fun(C1) ->
        lists:any(fun(C2) ->
            NewFreq1 = swap(Freq1, C1, C2),
            NewFreq2 = swap(Freq2, C2, C1),
            maps:size(NewFreq1) =:= maps:size(NewFreq2)
        end, Keys2)
    end, Keys1).

count_freq(Word) ->
    count_freq(Word, #{}).

count_freq(<<>>, Freq) ->
    Freq;
count_freq(<<C/utf8, Rest/binary>>, Freq) ->
    count_freq(Rest, maps:update_with(C, fun(V) -> V + 1 end, 1, Freq)).

swap(Freq, C1, C2) ->
    case C1 =:= C2 of
        true -> Freq;
        false ->
            Freq1 = maps:update_with(C1, fun(V) -> V - 1 end, Freq),
            Freq2 = case maps:get(C1, Freq1, 0) of
                0 -> maps:remove(C1, Freq1);
                _ -> Freq1
            end,
            Freq3 = maps:update_with(C2, fun(V) -> V + 1 end, 1, Freq2),
            Freq3
    end.