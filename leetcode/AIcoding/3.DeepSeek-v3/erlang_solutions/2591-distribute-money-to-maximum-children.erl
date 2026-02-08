-spec dist_money(Money :: integer(), Children :: integer()) -> integer().
dist_money(Money, Children) ->
    if
        Money < Children -> -1;
        true ->
            Max = min(Children, Money div 8),
            Rem = Money - Max * 8,
            Left = Children - Max,
            if
                Left =:= 0 ->
                    if
                        Rem =:= 0 -> Max;
                        true -> Max - 1
                    end;
                Left =:= 1 ->
                    if
                        Rem =:= 4 -> Max - 1;
                        Rem > 0 -> Max;
                        true -> Max
                    end;
                true ->
                    if
                        Rem >= Left -> Max;
                        true -> max(0, Max - (Left - Rem + 7) div 8)
                    end
            end
    end.