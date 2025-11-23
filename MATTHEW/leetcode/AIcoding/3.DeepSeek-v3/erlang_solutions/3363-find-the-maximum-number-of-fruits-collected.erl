-spec max_total_fruits(Fruits :: [[integer()]], StartPos :: integer(), K :: integer()) -> integer().
max_total_fruits(Fruits, StartPos, K) ->
    Left = lists:foldl(fun([Pos, Amount], Acc) -> 
                           if Pos =< StartPos -> Acc + Amount; true -> Acc end 
                       end, 0, Fruits),
    Right = lists:foldl(fun([Pos, Amount], Acc) -> 
                            if Pos >= StartPos -> Acc + Amount; true -> Acc end 
                        end, 0, Fruits),
    Max1 = max_left(Fruits, StartPos, K, Left),
    Max2 = max_right(Fruits, StartPos, K, Right),
    max(Max1, Max2).

max_left(Fruits, StartPos, K, Left) ->
    case Fruits of
        [] -> Left;
        [[Pos, Amount] | Rest] ->
            if Pos < StartPos ->
                Distance = StartPos - Pos,
                if Distance =< K ->
                    max_left(Rest, StartPos, K - Distance, Left + Amount);
                true -> Left
                end;
            true -> max_left(Rest, StartPos, K, Left)
            end
    end.

max_right(Fruits, StartPos, K, Right) ->
    case lists:reverse(Fruits) of
        [] -> Right;
        [[Pos, Amount] | Rest] ->
            if Pos > StartPos ->
                Distance = Pos - StartPos,
                if Distance =< K ->
                    max_right(lists:reverse(Rest), StartPos, K - Distance, Right + Amount);
                true -> Right
                end;
            true -> max_right(lists:reverse(Rest), StartPos, K, Right)
            end
    end.