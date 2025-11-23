-module(stone_game_ii).
-export([stone_game_ii/1]).

stone_game_ii(Piles) ->
    N = length(Piles),
    Memo = dict:new(),
    prefix_sum(Piles, 0, N, Memo).

prefix_sum(Piles, Start, M, Memo) ->
    N = length(Piles),
    Key = {Start, M},
    case dict:find(Key, Memo) of
        {ok, Value} ->
            Value;
        error ->
            if Start >= N then
                0
            else
                Sum = lists:sum(lists:sublist(Piles, Start + 1, N - Start)),
                Result = solve(Piles, Start, M, N, Memo, Sum),
                dict:store(Key, Result, Memo),
                Result
            end
    end.

solve(Piles, Start, M, N, Memo, Sum) ->
    MaxScore = lists:foldl(fun(X, Acc) ->
                                  Take = min(N - Start, 2 * M);
                                  if X > Take then
                                      Acc
                                  else
                                      NewStart = Start + X,
                                      RemainingSum = Sum - lists:sum(lists:sublist(Piles, Start + 1, X)),
                                      OpponentScore = prefix_sum(Piles, NewStart, max(M, X), Memo),
                                      Score = Sum - OpponentScore,
                                      max(Acc, Score)
                                  end
                              end,
                              0,
                              lists:seq(1, 2 * M)).