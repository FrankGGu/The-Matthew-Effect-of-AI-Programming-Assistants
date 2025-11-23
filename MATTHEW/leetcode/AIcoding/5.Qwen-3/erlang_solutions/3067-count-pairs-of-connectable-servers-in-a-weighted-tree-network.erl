-module(solution).
-export([count_pairs/2]).

count_pairs(Tree, Target) ->
    {_, _, Total} = dfs(1, -1, Tree, Target),
    Total.

dfs(Node, Parent, Tree, Target) ->
    Counts = maps:new(),
    {Counts, _, Total} = lists:foldl(
        fun(Child, {AccCounts, AccTotal, _}) ->
            {ChildCounts, ChildTotal, _} = dfs(Child, Node, Tree, Target),
            Combined = combine_counts(AccCounts, ChildCounts, Target),
            NewTotal = AccTotal + ChildTotal + maps:size(Combined),
            {Combined, NewTotal, NewTotal}
        end,
        {Counts, 0, 0},
        get_children(Node, Tree)
    ),
    {Counts, 0, Total}.

get_children(Node, Tree) ->
    lists:filter(fun({N, _}) -> N /= Node end, Tree).

combine_counts(Counts1, Counts2, Target) ->
    maps:fold(
        fun(Key, Value, Acc) ->
            case maps:find(Target - Key, Counts2) of
                {ok, V} -> maps:put(Key, Value + V, Acc);
                error -> Acc
            end
        end,
        maps:merge(Counts1, Counts2),
        Counts1
    ).