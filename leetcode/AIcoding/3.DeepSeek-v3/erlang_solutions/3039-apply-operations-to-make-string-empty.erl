-spec make_string_empty(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
make_string_empty(S) ->
    Freq = lists:foldl(fun(Char, Acc) -> 
                           maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                       end, #{}, unicode:characters_to_list(S)),
    MaxFreq = case maps:size(Freq) of
                  0 -> 0;
                  _ -> lists:max(maps:values(Freq))
              end,
    Chars = lists:filter(fun(Char) -> 
                            maps:get(Char, Freq) =:= MaxFreq 
                         end, maps:keys(Freq)),
    LastChars = lists:foldl(fun(Char, Acc) -> 
                                case lists:last(Acc) of
                                    {C, _} when C =:= Char -> Acc;
                                    _ -> Acc ++ [{Char, lists:last(lists:filter(fun(X) -> X =:= Char end, unicode:characters_to_list(S)))}]
                                end
                            end, [], lists:sort(Chars)),
    Result = lists:map(fun({_, Pos}) -> Pos end, LastChars),
    unicode:characters_to_binary(lists:sort(Result)).