-spec number_of_winning_players(Players :: [[integer()]], Queries :: [integer()]) -> [integer()].
number_of_winning_players(Players, Queries) ->
    Sorted = lists:sort(fun([A1, _], [A2, _]) -> A1 =< A2 end, Players),
    Maxs = lists:foldl(fun([A, B], Acc) ->
        case Acc of
            [] -> [{A, B}];
            [{PrevA, PrevB} | _] ->
                if
                    B > PrevB -> [{A, B} | Acc];
                    true -> Acc
                end
        end
    end, [], Sorted),
    MaxsRev = lists:reverse(Maxs),
    lists:map(fun(Q) ->
        {Left, Right} = lists:splitwith(fun({A, _}) -> A =< Q end, MaxsRev),
        case Left of
            [] -> 0;
            _ -> length(Left)
        end
    end, Queries).