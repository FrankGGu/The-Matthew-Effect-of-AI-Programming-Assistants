-module(solution).
-export([countSmaller/1]).

countSmaller(Nums) ->
    countSmaller(Nums, [], []).

countSmaller([], _, Result) ->
    lists:reverse(Result);
countSmaller([H | T], Acc, Result) ->
    {Count, NewAcc} = findSmaller(H, Acc),
    countSmaller(T, [H | Acc], [Count | Result]).

findSmaller(_, []) ->
    {0, []};
findSmaller(X, [Y | Ys]) ->
    if
        X > Y ->
            {1 + Count, [Y | Ys]} when {Count, _} = findSmaller(X, Ys);
        true ->
            {Count, [Y | Ys]} when {Count, _} = findSmaller(X, Ys)
    end.