-module(solution).
-export([longest_square_streak/1]).

longest_square_streak(Numbers) ->
    UniqueNumbers = lists:usort(Numbers),
    Squares = lists:map(fun(X) -> X * X end, UniqueNumbers),
    Streaks = lists:map(fun(X) -> find_streak(X, UniqueNumbers) end, Squares),
    lists:max([0 | Streaks]).

find_streak(Square, UniqueNumbers) ->
    case lists:member(Square, UniqueNumbers) of
        true -> 1 + find_streak(Square + 1, UniqueNumbers);
        false -> 0
    end.