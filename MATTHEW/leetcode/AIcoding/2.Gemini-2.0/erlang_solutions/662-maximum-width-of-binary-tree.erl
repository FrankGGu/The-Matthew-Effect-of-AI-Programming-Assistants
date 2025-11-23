-module(solution).
-export([widthOfBinaryTree/1]).

widthOfBinaryTree(Root) ->
    widthOfBinaryTree(Root, 0, 1, []).

widthOfBinaryTree(null, _, _, Acc) ->
    lists:foldl(fun({_, Min, Max}, Acc2) ->
                        max(Acc2, Max - Min + 1)
                end, 0, Acc);

widthOfBinaryTree(Node, Depth, Pos, Acc) ->
    NewAcc =
        case lists:keyfind(Depth, 1, Acc) of
            false ->
                [{Depth, Pos, Pos} | Acc];
            {_, Min, _} ->
                lists:keyreplace(Depth, 1, Acc, {Depth, Min, Pos})
        end,
    widthOfBinaryTree(get_left(Node), Depth + 1, Pos * 2,
                       widthOfBinaryTree(get_right(Node), Depth + 1, Pos * 2 + 1, NewAcc)).

get_left(Node) ->
    case Node of
        {Val, Left, Right} ->
            Left;
        _ ->
            null
    end.

get_right(Node) ->
    case Node of
        {Val, Left, Right} ->
            Right;
        _ ->
            null
    end.