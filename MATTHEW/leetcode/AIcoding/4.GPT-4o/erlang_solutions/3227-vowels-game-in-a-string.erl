-module(vowels_game).
-export([is_winner/1]).

is_winner(String) ->
    Vowels = "aeiou",
    Points = fun(Char) ->
        case lists:member(Char, Vowels) of
            true -> 1;
            false -> 0
        end
    end,
    Player1Score = lists:sum(lists:map(Points, string:to_list(String))),
    Player2Score = length(String) - Player1Score,
    case Player1Score > Player2Score of
        true -> "Player 1 wins";
        false -> "Player 2 wins"
    end.