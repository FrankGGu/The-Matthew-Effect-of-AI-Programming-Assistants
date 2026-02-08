-spec find_winner(Players :: [integer()], K :: integer()) -> integer().
find_winner(Players, K) ->
    find_winner(Players, [], 0, K).

find_winner([Winner], _, Wins, K) when Wins >= K ->
    Winner;
find_winner([Winner], [], _, _) ->
    Winner;
find_winner([Winner], [Opponent | Rest], Wins, K) ->
    find_winner([Winner, Opponent], Rest, Wins, K);
find_winner([P1, P2 | Rest], Queue, Wins, K) when P1 > P2 ->
    NewWins = case Queue of
        [] -> Wins + 1;
        _ -> 1
    end,
    if
        NewWins >= K -> P1;
        true -> find_winner([P1 | Rest], Queue ++ [P2], NewWins, K)
    end;
find_winner([P1, P2 | Rest], Queue, _Wins, K) ->
    find_winner([P2 | Rest], Queue ++ [P1], 1, K).