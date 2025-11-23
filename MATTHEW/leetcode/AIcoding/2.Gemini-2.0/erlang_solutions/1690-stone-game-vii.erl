-module(stone_game_vii).
-export([stone_game_vii/1]).

stone_game_vii(Stones) ->
    N = length(Stones),
    Sum = lists:sum(Stones),
    memo(Stones, 0, N - 1, #{}, Sum).

memo(Stones, L, R, Memo, Sum) ->
    case maps:get({L, R}, Memo, undefined) of
        Value when Value /= undefined ->
            Value;
        _ ->
            case L == R of
                true ->
                    0;
                false ->
                    Score1 = Sum - lists:nth(L + 1, Stones) - memo(Stones, L + 1, R, Memo, Sum - lists:nth(L + 1, Stones)),
                    Score2 = Sum - lists:nth(R + 1, Stones) - memo(Stones, L, R - 1, Memo, Sum - lists:nth(R + 1, Stones)),
                    Result = max(Score1, Score2),
                    maps:put({L, R}, Result, Memo)
            end
    end.