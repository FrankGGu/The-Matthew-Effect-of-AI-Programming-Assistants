-module(solution).
-export([winning_players/1]).

winning_players(Ranks) ->
    Players = lists:seq(1, length(Ranks)),
    Sorted = lists:sort(fun(A, B) -> element(2, A) < element(2, B) end, lists:zip(Players, Ranks)),
    Winners = lists:foldl(fun({Player, Rank}, {Acc, PrevRank, Count}) ->
        if
            Rank < PrevRank ->
                {Acc ++ [Player], Rank, 1};
            Rank == PrevRank ->
                {Acc ++ [Player], Rank, Count + 1};
            true ->
                {Acc, PrevRank, Count}
        end
    end, {[], hd(lists:map(fun({_, R}) -> R end, Sorted)), 1}, Sorted),
    lists:tl(hd(Winners)).

winning_players([]) ->
    [].