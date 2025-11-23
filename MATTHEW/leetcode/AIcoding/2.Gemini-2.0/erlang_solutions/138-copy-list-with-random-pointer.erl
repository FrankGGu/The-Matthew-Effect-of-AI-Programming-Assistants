-module(copy_list_with_random_pointer).
-export([copyRandomList/1]).

-spec copyRandomList(list()) -> list().
copyRandomList(Lists) ->
    Map = create_map(Lists),
    copy_list(Lists, Map).

create_map([]) ->
    [];
create_map([H|T]) ->
    [{H, {element(1, H), null, null}} | create_map(T)].

copy_list([], _) ->
    [];
copy_list([H|T], Map) ->
    NewNode = copy_node(H, Map),
    [NewNode | copy_list(T, Map)].

copy_node(Node, Map) ->
    case lists:keyfind(Node, 1, Map) of
        false ->
            null;
        {_, {Val, _, _}} ->
            {Val, get_new_next(Node, Map), get_new_random(Node, Map)}
    end.

get_new_next(Node, Map) ->
    case element(2, Node) of
        null ->
            null;
        NextNode ->
            case lists:keyfind(NextNode, 1, Map) of
                false ->
                    null;
                {_, {Val, _, _}} ->
                    {Val, null, null}
            end
    end.

get_new_random(Node, Map) ->
    case element(3, Node) of
        null ->
            null;
        RandomNode ->
            case lists:keyfind(RandomNode, 1, Map) of
                false ->
                    null;
                {_, {Val, _, _}} ->
                    {Val, null, null}
            end
    end.