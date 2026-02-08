-module(maximize_score).
-export([maximumScore/2]).

maximumScore(Nums, Queries) ->
    SortedNums = lists:sort(Nums),
    SortedQueries = lists:sort([{Q, I} || {I, Q} <- lists:zip(lists:seq(1, length(Queries)), Queries)], fun({A, _}, {B, _}) -> A < B end),
    {_, Result} = solve(SortedNums, SortedQueries, 0, [], []).

solve([], [], Score, _, Acc) ->
    {Score, lists:reverse(Acc)};
solve([], [{_, Index} | RestQueries], Score, Stack, Acc) ->
    solve([], RestQueries, Score, Stack, [Score || _ <- lists:seq(1, length([{_, Index} | RestQueries]))] ++ Acc);
solve(Nums, [], Score, Stack, Acc) ->
    {NewScore, NewStack} = update_score(Nums, Stack, Score),
    solve([], [], NewScore, NewStack, lists:reverse(Acc));
solve(Nums, [{Query, Index} | RestQueries], Score, Stack, Acc) ->
    {RemainingNums, ApplicableNums} = lists:partition(fun(Num) -> Num > Query end, Nums),
    {NewScore, NewStack} = update_score(ApplicableNums, Stack, Score),
    solve(RemainingNums, RestQueries, NewScore, NewStack, [NewScore | Acc]).

update_score([], Stack, Score) ->
    {Score, Stack};
update_score(Nums, Stack, Score) ->
    {NewStack, NewScore} = lists:foldl(fun(Num, {AccStack, AccScore}) ->
                                               case AccStack of
                                                   [] ->
                                                       {[Num], AccScore + Num};
                                                   [Top | Rest] ->
                                                       if Num > Top ->
                                                           {[Num | AccStack], AccScore + Num};
                                                       true ->
                                                           {AccStack, AccScore}
                                                       end
                                               end
                                       end, {Stack, Score}, Nums),
    {NewScore, NewStack}.