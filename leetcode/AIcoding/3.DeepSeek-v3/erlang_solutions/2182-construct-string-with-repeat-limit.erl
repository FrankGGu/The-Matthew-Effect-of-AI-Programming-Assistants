-spec repeated_character_replacement(S :: unicode:unicode_binary(), RepeatLimit :: integer()) -> unicode:unicode_binary().
repeated_character_replacement(S, RepeatLimit) ->
    Freq = lists:foldl(fun(Char, Acc) -> 
                           maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                       end, #{}, unicode:characters_to_list(S)),
    Heap = maps:fold(fun(Char, Count, Acc) -> 
                         [{Count, Char} | Acc]
                      end, [], Freq),
    SortedHeap = lists:sort(fun({Cnt1, _}, {Cnt2, _}) -> Cnt1 > Cnt2 end, Heap),
    build_string(SortedHeap, RepeatLimit, <<>>, none, 0).

build_string([], _RepeatLimit, Acc, _LastChar, _LastCount) ->
    Acc;
build_string(Heap, RepeatLimit, Acc, LastChar, LastCount) ->
    case find_next_char(Heap, LastChar, LastCount, RepeatLimit) of
        {none, NewHeap} ->
            build_string(NewHeap, RepeatLimit, Acc, none, 0);
        {{Count, Char}, NewHeap} ->
            NewAcc = <<Acc/binary, Char>>,
            NewLastCount = if Char =:= LastChar -> LastCount + 1; true -> 1 end,
            UpdatedHeap = if Count > 1 -> 
                              lists:sort(fun({Cnt1, _}, {Cnt2, _}) -> Cnt1 > Cnt2 end, 
                                         [{Count - 1, Char} | NewHeap]);
                            true -> NewHeap
                         end,
            build_string(UpdatedHeap, RepeatLimit, NewAcc, Char, NewLastCount)
    end.

find_next_char([], _LastChar, _LastCount, _RepeatLimit) ->
    {none, []};
find_next_char([{Count, Char} | Rest], LastChar, LastCount, RepeatLimit) ->
    if Char =/= LastChar orelse LastCount < RepeatLimit ->
           {{Count, Char}, Rest};
       true ->
           case find_next_char(Rest, LastChar, LastCount, RepeatLimit) of
               {none, NewRest} ->
                   {none, [{Count, Char} | NewRest]};
               {Found, NewRest} ->
                   {Found, [{Count, Char} | NewRest]}
           end
    end.