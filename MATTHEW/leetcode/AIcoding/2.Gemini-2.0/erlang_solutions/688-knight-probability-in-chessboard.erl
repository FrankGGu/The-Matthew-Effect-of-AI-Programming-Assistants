-module(knight_probability).
-export([knight_probability/3]).

knight_probability(N, K, Row, Column) ->
    memo(N, K, Row, Column).

memo(N, K, Row, Column) ->
    memo(N, K, Row, Column, dict:new()).

memo(N, 0, Row, Column, Dict) ->
    case is_valid(N, Row, Column) of
        true -> 1.0;
        false -> 0.0
    end;
memo(N, K, Row, Column, Dict) ->
    case dict:is_key({K, Row, Column}, Dict) of
        true -> dict:fetch({K, Row, Column}, Dict);
        false ->
            Probability = calculate_probability(N, K, Row, Column, Dict),
            NewDict = dict:store({K, Row, Column}, Probability, Dict),
            Probability
    end.

calculate_probability(N, K, Row, Column, Dict) ->
    Moves = [
        {-2, -1}, {-2, 1}, {-1, -2}, {-1, 2},
        {1, -2}, {1, 2}, {2, -1}, {2, 1}
    ],
    Probability = lists:sum([
        memo(N, K - 1, Row + DR, Column + DC, Dict) / 8.0
        || {DR, DC} <- Moves
    ]),
    Probability.

is_valid(N, Row, Column) ->
    Row >= 0 and Row < N and Column >= 0 and Column < N.