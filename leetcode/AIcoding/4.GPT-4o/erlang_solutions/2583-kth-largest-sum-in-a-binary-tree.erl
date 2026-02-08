-module(solution).
-export([kthLargestSum/2]).

-record(tree_node, {val, left, right}).

kthLargestSum(Tree, K) ->
    Sums = lists:flatmap(fun(Node) -> calc_sums(Node, 0) end, [Tree]),
    UniqueSums = lists:usort(Sums),
    Length = length(UniqueSums),
    if Length >= K ->
        lists:nth(Length - K + 1, UniqueSums);
    true ->
        -1
    end.

calc_sums(Node, Acc) ->
    case Node of
        #tree_node{val=Val, left=Left, right=Right} ->
            NewAcc = Acc + Val,
            lists:append([NewAcc],
                case {Left, Right} of
                    {none, none} -> [];
                    {none, _} -> calc_sums(Right, NewAcc);
                    {_, none} -> calc_sums(Left, NewAcc);
                    {_, _} -> calc_sums(Left, NewAcc) ++ calc_sums(Right, NewAcc)
                end
            )
    end.