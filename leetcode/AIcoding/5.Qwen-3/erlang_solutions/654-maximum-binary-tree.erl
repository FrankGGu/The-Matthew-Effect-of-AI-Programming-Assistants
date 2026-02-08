-module(maximum_binary_tree).
-export([construct/1]).

construct([]) -> nil;
construct([H|T]) ->
    {Max, Index} = lists:foldl(fun(X, {CurrentMax, CurrentIndex}) ->
        if X > CurrentMax -> {X, 0};
           true -> {CurrentMax, CurrentIndex + 1}
        end
    end, {H, 0}, T),
    Left = construct(lists:sublist(T, Index)),
    Right = construct(lists:sublist(T, Index+1, length(T) - Index - 1)),
    {node, H, Left, Right}.

tree_to_list(nil) -> [];
tree_to_list({node, Val, Left, Right}) ->
    [Val | [tree_to_list(Left), tree_to_list(Right)]].