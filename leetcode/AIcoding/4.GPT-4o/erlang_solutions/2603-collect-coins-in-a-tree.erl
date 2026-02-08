-module(solution).
-export([collect_coins/2]).

collect_coins(Tree, Coins) ->
    collect_coins(Tree, Coins, 0, 0).

collect_coins([], _, Cost, _) -> 
    Cost;
collect_coins(Tree, Coins, Cost, Parent) ->
    case tree_to_list(Tree) of
        [] -> Cost;
        _ ->
            {Current, Children} = hd(tree_to_list(Tree)),
            NewCost = Cost + (if 
                Current /= 0 -> 
                    0; 
                true -> 
                    1
            end),
            lists:foldl(fun(Child, Acc) -> 
                collect_coins(Child, Coins, Acc + 1, Current) 
            end, NewCost, Children)
    end.

tree_to_list({Value, Children}) -> 
    [{Value, Children} | lists:map(fun tree_to_list/1, Children)];
tree_to_list([]) -> [].