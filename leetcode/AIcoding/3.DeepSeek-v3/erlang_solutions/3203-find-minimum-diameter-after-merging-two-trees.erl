-module(solution).
-export([minimum_diameter/2]).

minimum_diameter(Tree1, Tree2) ->
    {D1, C1} = get_diameter(Tree1),
    {D2, C2} = get_diameter(Tree2),
    MinD = lists:min([D1, D2]),
    MaxD = lists:max([D1, D2]),
    case (MaxD + 1) div 2 + (MinD + 1) div 2 + 1 of
        Candidate when Candidate >= MaxD -> Candidate;
        _ -> MaxD
    end.

get_diameter(Tree) ->
    {D, _} = dfs(Tree, -1),
    {D, find_center(Tree, D)}.

dfs(Node, Parent) ->
    MaxDepth1 = 0,
    MaxDepth2 = 0,
    Diameter = 0,
    lists:foldl(fun(Child, {MaxD1, MaxD2, D}) ->
        if Child =/= Parent ->
            {ChildDepth, ChildDiam} = dfs(Child, Node),
            NewD = max(D, ChildDiam),
            if ChildDepth >= MaxD1 ->
                {ChildDepth, MaxD1, NewD};
            true when ChildDepth >= MaxD2 ->
                {MaxD1, ChildDepth, NewD};
            true ->
                {MaxD1, MaxD2, NewD}
            end;
        true ->
            {MaxD1, MaxD2, D}
        end
    end, {MaxDepth1, MaxDepth2, Diameter}, maps:get(Node, tree(), [])),
    Diameter1 = max(Diameter, MaxDepth1 + MaxDepth2),
    {MaxDepth1 + 1, Diameter1}.

find_center(Node, Diameter) ->
    Path = find_path(Node, -1, Diameter),
    lists:nth((length(Path) + 1) div 2, Path).

find_path(Node, Parent, Remaining) ->
    if Remaining =:= 0 ->
        [Node];
    true ->
        lists:foldl(fun(Child, Acc) ->
            if Child =/= Parent ->
                case find_path(Child, Node, Remaining - 1) of
                    [] -> Acc;
                    Path -> [Node | Path]
                end;
            true ->
                Acc
            end
        end, [], maps:get(Node, tree(), []))
    end.

tree() ->
    #{1 => [2, 3], 2 => [1, 4], 3 => [1], 4 => [2]}.