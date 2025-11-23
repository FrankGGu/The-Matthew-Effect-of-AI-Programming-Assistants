-spec maximum_time(Time :: unicode:unicode_binary()) -> unicode:unicode_binary().
maximum_time(Time) ->
    [H1, H2, $:, M1, M2] = binary_to_list(Time),
    NewH1 = case H1 of
                $? -> if H2 == $? -> $2;
                         H2 =< $3 -> $2;
                         true -> $1
                      end;
                _ -> H1
            end,
    NewH2 = case H2 of
                $? -> if NewH1 == $2 -> $3;
                         true -> $9
                      end;
                _ -> H2
            end,
    NewM1 = case M1 of
                $? -> $5;
                _ -> M1
            end,
    NewM2 = case M2 of
                $? -> $9;
                _ -> M2
            end,
    list_to_binary([NewH1, NewH2, $:, NewM1, NewM2]).