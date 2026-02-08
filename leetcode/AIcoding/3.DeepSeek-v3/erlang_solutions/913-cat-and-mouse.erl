-module(cat_mouse).
-export([catMouseGame/1]).

catMouseGame(Graph) ->
    N = length(Graph),
    memo = ets:new(memo, [set, private]),
    Result = dp(1, 2, 0, Graph, N, memo),
    ets:delete(memo),
    Result.

dp(Mouse, Cat, Turn, Graph, N, Memo) ->
    case ets:lookup(Memo, {Mouse, Cat, Turn}) of
        [{_, Result}] -> Result;
        [] ->
            Result = case Turn of
                0 -> % Mouse's turn
                    if Mouse == 0 -> 0; % Mouse wins
                       true ->
                            NextStates = [dp(Next, Cat, 1, Graph, N, Memo) || Next <- lists:nth(Mouse + 1, Graph)],
                            case lists:member(0, NextStates) of
                                true -> 0;
                                false ->
                                    case lists:all(fun(X) -> X == 2 end, NextStates) of
                                        true -> 2;
                                        false -> 1
                                    end
                            end
                    end;
                1 -> % Cat's turn
                    if Cat == Mouse -> 2; % Cat wins
                       Cat == 0 -> 1; % Mouse wins (cat can't move to hole)
                       true ->
                            NextStates = [dp(Mouse, Next, 0, Graph, N, Memo) || Next <- lists:nth(Cat + 1, Graph), Next /= 0],
                            case lists:member(2, NextStates) of
                                true -> 2;
                                false ->
                                    case lists:all(fun(X) -> X == 1 end, NextStates) of
                                        true -> 1;
                                        false -> 0
                                    end
                            end
                    end
            end,
            ets:insert(Memo, {{Mouse, Cat, Turn}, Result}),
            Result
    end.