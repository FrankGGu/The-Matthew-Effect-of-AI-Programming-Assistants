-module(cbt_inserter).
-export([new/1, insert/2, get_root/1]).

new(Root) ->
    {queue:from_list([Root]), Root}.

insert({Queue, Root}, V) ->
    {H, T} = queue:head(Queue),
    H1 = H#node{left = case H#node.left of
        null ->
            {node, V, null, null};
        _ ->
            null
    },
    H2 = H#node{right = case H#node.right of
        null ->
            {node, V, null, null};
        _ ->
            null
    },
    NewQueue = case H#node.left of
        null ->
            queue:replace_head(Queue, H1);
        _ ->
            NewQueue2 = case H#node.right of
                null ->
                    queue:replace_head(Queue, H2);
                _ ->
                    queue:drop(Queue)
            end
    end,
    NewQueue1 = case H#node.left of
        null ->
            NewQueue;
        _ ->
            NewQueue2
    end,

    case H#node.left of
        null ->
            {NewQueue1, H#node.val};
        _ ->
            case H#node.right of
                null ->
                    {NewQueue1, H#node.val};
                _ ->
                    {queue:in({node, V, null, null}, NewQueue1), H#node.val}
            end
    end.

get_root({_, Root}) ->
    Root.