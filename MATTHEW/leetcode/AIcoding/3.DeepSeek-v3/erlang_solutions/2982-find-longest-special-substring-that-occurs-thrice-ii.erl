-spec maximum_length(s :: unicode:unicode_binary()) -> integer().
maximum_length(S) ->
    List = unicode:characters_to_list(S),
    Counts = lists:foldl(fun(Char, Acc) ->
                            maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, List),
    Freqs = lists:foldl(fun({_, V}, Acc) ->
                            maps:update_with(V, fun(C) -> C + 1 end, 1, Acc)
                         end, #{}, maps:to_list(Counts)),
    case maps:size(Freqs) of
        0 -> 0;
        _ ->
            MaxFreq = lists:max(maps:keys(Freqs)),
            case maps:get(MaxFreq, Freqs) of
                C when C >= 3 -> MaxFreq;
                _ -> 
                    case MaxFreq - 1 of
                        Next when Next >= 1 ->
                            case maps:get(Next, Freqs, 0) >= 3 of
                                true -> Next;
                                false -> 0
                            end;
                        _ -> 0
                    end
            end
    end.