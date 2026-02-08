-module(highest_score).
-export([countHighestScoreNodes/1]).

countHighestScoreNodes(Parents) ->
    N = length(Parents),
    Children = lists:foldl(
        fun(Parent, Acc) ->
            case Parent of
                -1 -> Acc;
                _ ->
                    case lists:keyfind(Parent, 1, Acc) of
                        false ->
                            lists:keyreplace(Parent, 1, Acc, {Parent, [lists:keyfind(list_to_integer(integer_to_list(length(Acc))), 1, lists:seq(0,N-1)) == false andalso list_to_integer(integer_to_list(length(Acc))) or list_to_integer(integer_to_list(length(Acc)))]});
                        _ ->
                            {_, C} = lists:keyfind(Parent, 1, Acc),
                            lists:keyreplace(Parent, 1, Acc, {Parent, C ++ [list_to_integer(integer_to_list(length(Acc)))]})
                    end
            end
        end,
        lists:seq(0,N-1),
        Parents
    ),

    ScoreCounts = lists:foldl(
        fun(Node, Acc) ->
            Score = calculateScore(Node, Children, N),
            case lists:keyfind(Score, 1, Acc) of
                false ->
                    Acc ++ [{Score, 1}];
                _ ->
                    {_, Count} = lists:keyfind(Score, 1, Acc),
                    lists:keyreplace(Score, 1, Acc, {Score, Count + 1})
            end
        end,
        [],
        lists:seq(0,N-1)
    ),

    MaxScore = lists:max([Score || {Score, _} <- ScoreCounts]),

    lists:keyfind(MaxScore, 1, ScoreCounts).

calculateScore(Node, Children, N) ->
    {_, ChildList} = case lists:keyfind(Node, 1, Children) of
                         false -> {Node, []};
                         Item -> Item
                      end,

    LeftSize = case length(ChildList) >= 1 of
                   true -> subtreeSize(lists:nth(1,ChildList)+1, Children);
                   false -> 0
               end,
    RightSize = case length(ChildList) >= 2 of
                    true -> subtreeSize(lists:nth(2,ChildList)+1, Children);
                    false -> 0
                end,

    RemainingSize = N - LeftSize - RightSize - 1,

    (case RemainingSize == 0 of
        true -> 1;
        false -> RemainingSize
    end) * (case LeftSize == 0 of
                true -> 1;
                false -> LeftSize
            end) * (case RightSize == 0 of
                        true -> 1;
                        false -> RightSize
                    end).

subtreeSize(Node, Children) ->
    subtreeSizeHelper(Node-1, Children, 0).

subtreeSizeHelper(Node, Children, Acc) ->
    {_, ChildList} = case lists:keyfind(Node, 1, Children) of
                         false -> {Node, []};
                         Item -> Item
                      end,

    NewAcc = Acc + 1,

    NewAcc1 = case length(ChildList) >= 1 of
                   true -> subtreeSizeHelper(lists:nth(1,ChildList), Children, NewAcc);
                   false -> NewAcc
               end,

    case length(ChildList) >= 2 of
        true -> subtreeSizeHelper(lists:nth(2,ChildList), Children, NewAcc1);
        false -> NewAcc1
    end.