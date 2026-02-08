-module(solution).
-export([count_highest_score_nodes/1]).

count_highest_score_nodes(Parents) ->
    N = length(Parents),
    Children = build_children(Parents),
    {MaxScore, Count} = count_nodes(0, N, Children),
    Count.

build_children(Parents) ->
    N = length(Parents),
    Children = lists:duplicate(N, []),
    build_children(Parents, Children, 1).

build_children([], Children, _) -> Children;
build_children([Parent | Rest], Children, I) ->
    if 
        Parent =:= -1 -> 
            NewChildren = Children;
        true -> 
            {Before, [ChildList | After]} = lists:split(Parent, Children),
            NewChildList = [I | ChildList],
            NewChildren = Before ++ [NewChildList] ++ After
    end,
    build_children(Rest, NewChildren, I + 1).

count_nodes(Node, N, Children) ->
    case Children of
        [] -> {0, 0};
        _ ->
            ChildList = lists:nth(Node + 1, Children),
            {Count, Scores} = count_and_score(Node, N, Children, ChildList, 1, []),
            case Scores of
                [] -> 
                    Score = N - 1,
                    {Score, 1};
                _ ->
                    Total = lists:foldl(fun(C, Acc) -> C * Acc end, 1, Scores),
                    Score = Total * max(1, N - 1 - Count),
                    {Score, 1}
            end
    end.

count_and_score(_, _, _, [], Count, Scores) -> {Count, Scores};
count_and_score(Node, N, Children, [Child | Rest], Count, Scores) ->
    {ChildCount, ChildScore} = count_nodes(Child, N, Children),
    count_and_score(Node, N, Children, Rest, Count + ChildCount, [ChildCount + 1 | Scores]).

count_nodes(Node, N, Children) ->
    ChildList = lists:nth(Node + 1, Children),
    {Count, Scores} = count_and_score(Node, N, Children, ChildList, 0, []),
    case Scores of
        [] -> 
            Score = N - 1,
            {Score, 1};
        _ ->
            Total = lists:foldl(fun(C, Acc) -> C * Acc end, 1, Scores),
            Score = Total * max(1, N - 1 - Count),
            {Score, 1}
    end.

count_highest_score_nodes(Parents) ->
    N = length(Parents),
    Children = build_children(Parents),
    {MaxScore, Count} = traverse(0, N, Children, -1, 0),
    Count.

traverse(Node, N, Children, MaxScore, Count) ->
    ChildList = lists:nth(Node + 1, Children),
    {ChildCount, Scores} = count_and_score(Node, N, Children, ChildList, 0, []),
    Score = case Scores of
        [] -> N - 1;
        _ -> 
            Total = lists:foldl(fun(C, Acc) -> C * Acc end, 1, Scores),
            Total * max(1, N - 1 - ChildCount)
    end,
    if
        Score > MaxScore -> NewMax = Score, NewCount = 1;
        Score =:= MaxScore -> NewMax = MaxScore, NewCount = Count + 1;
        true -> NewMax = MaxScore, NewCount = Count
    end,
    lists:foldl(fun(Child, {CurrentMax, CurrentCount}) ->
        traverse(Child, N, Children, CurrentMax, CurrentCount)
    end, {NewMax, NewCount}, ChildList).