-spec maximum_time(Time :: unicode:unicode_binary()) -> unicode:unicode_binary().
maximum_time(Time) ->
    [H1, H2, $:, M1, M2] = binary_to_list(Time),
    NewH1 = case H1 of
                $$ -> 
                    case H2 of
                        $$ -> $2;
                        H2 when H2 < $4 -> $2;
                        _ -> $1
                    end;
                H1 -> H1
            end,
    NewH2 = case H2 of
                $$ ->
                    case NewH1 of
                        $2 -> $3;
                        _ -> $9
                    end;
                H2 -> H2
            end,
    NewM1 = case M1 of
                $$ -> $5;
                M1 -> M1
            end,
    NewM2 = case M2 of
                $$ -> $9;
                M2 -> M2
            end,
    list_to_binary([NewH1, NewH2, $:, NewM1, NewM2]).