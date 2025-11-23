-module(solution).
-export([construct_binary_tree/2]).

-type node() :: {none} | {Value, node(), node()}.

construct_binary_tree(Preorder, Postorder) ->
    construct(Preorder, Postorder).

construct([], _) -> none;
construct(_, []) -> none;
construct([Root | PreorderTail], Postorder) ->
    case Postorder of
        [] -> none;
        [Root | PostorderTail2] -> 
            {Root, 
             construct(PreorderTail, lists:sublist(Postorder, 0, length(PreorderTail))),
             construct(PreorderTail, PostorderTail2)}
    end.