-spec percentage_letter(S :: unicode:unicode_binary(), Letter :: char()) -> float().
percentage_letter(S, Letter) ->
    Total = byte_size(S),
    Count = lists:foldl(fun(C, Acc) -> 
                            if C =:= Letter -> Acc + 1; true -> Acc end
                        end, 0, binary_to_list(S)),
    (Count / Total) * 100.