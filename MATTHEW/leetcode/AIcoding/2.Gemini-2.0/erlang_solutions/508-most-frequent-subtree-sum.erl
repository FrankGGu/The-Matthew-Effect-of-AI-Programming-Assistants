-module(most_frequent_subtree_sum).
-export([find_frequent_tree_sum/1]).

-spec find_frequent_tree_sum(Tree :: tree()) -> [integer()].
find_frequent_tree_sum(Tree) ->
    {_Sum, Frequencies} = subtree_sum_helper(Tree, []),
    MaxFrequency = lists:max([V || {_Key, V} <- Frequencies]),
    [Key || {Key, Value} <- Frequencies, Value == MaxFrequency].

-spec subtree_sum_helper(Tree :: tree(), Frequencies :: [{integer(), integer()}]) -> {integer(), [{integer(), integer()}]}.
subtree_sum_helper(null, Frequencies) ->
    {0, Frequencies};
subtree_sum_helper({Val, Left, Right}, Frequencies) ->
    {LeftSum, Frequencies1} = subtree_sum_helper(Left, Frequencies),
    {RightSum, Frequencies2} = subtree_sum_helper(Right, Frequencies1),
    Sum = Val + LeftSum + RightSum,
    NewFrequencies = update_frequency(Sum, Frequencies2),
    {Sum, NewFrequencies}.

-spec update_frequency(Sum :: integer(), Frequencies :: [{integer(), integer()}]) -> [{integer(), integer()}].
update_frequency(Sum, Frequencies) ->
    case lists:keyfind(Sum, 1, Frequencies) of
        false ->
            [{Sum, 1} | Frequencies];
        {Sum, Count} ->
            lists:keyreplace(Sum, 1, Frequencies, {Sum, Count + 1})
    end.

-type tree() :: {integer(), tree(), tree()} | null.