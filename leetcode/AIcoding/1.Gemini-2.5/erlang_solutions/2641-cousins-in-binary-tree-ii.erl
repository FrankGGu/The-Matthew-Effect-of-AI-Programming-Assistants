-module(solution).
-export([replace_cousins_sum/1]).

replace_cousins_sum(Root) ->
    case Root of
        nil -> nil;
        _ ->
            % Pass 1: Collect level sums and parent-children sums
            % LevelSums: #{Level => TotalSumOfNodesAtLevel}
            % ParentChildrenTotalSums: #{ParentNodeRef => SumOfChildrenValuesOfParentNodeRef}
            InitialAcc = #{level_sums => #{}, parent_child_sums => #{}},
            #{level_sums := LevelSums, parent_child_sums := ParentChildrenTotalSums} =
                collect_sums(Root, 0, InitialAcc),

            % Pass 2: Reconstruct tree with new values
            reconstruct_tree(Root, 0, nil, LevelSums, ParentChildrenTotalSums)
    end.

collect_sums(nil, _, Acc) ->
    Acc;
collect_sums({Val, Left, Right} = Node, Level, #{level_sums := LS, parent_child_sums := PCS} = Acc) ->
    % Update LevelSums: Add current node's value to its level's total sum
    NewLS = maps:update_with(Level, fun(S) -> S + Val end, Val, LS),

    % Calculate sum of children for the current node (if it's a parent)
    ChildrenSum = get_children_sum(Left, Right),
    NewPCS = maps:put(Node, ChildrenSum, PCS), % Store sum of children for this Node (as parent)

    Acc1 = #{level_sums := NewLS, parent_child_sums := NewPCS},

    % Recurse for left and right children
    Acc2 = collect_sums(Left, Level + 1, Acc1),
    collect_sums(Right, Level + 1, Acc2).

get_children_sum(nil, nil) -> 0;
get_children_sum({LVal,_,_}, nil) -> LVal;
get_children_sum(nil, {RVal,_,_}) -> RVal;
get_children_sum({LVal,_,_}, {RVal,_,_}) -> LVal + RVal.

reconstruct_tree(nil, _, _, _, _) ->
    nil;
reconstruct_tree({Val, Left, Right} = Node, Level, ParentNode, LevelSums, ParentChildrenTotalSums) ->
    NewVal = calculate_new_value(Node, Level, ParentNode, LevelSums, ParentChildrenTotalSums),
    NewLeft = reconstruct_tree(Left, Level + 1, Node, LevelSums, ParentChildrenTotalSums),
    NewRight = reconstruct_tree(Right, Level + 1, Node, LevelSums, ParentChildrenTotalSums),
    {NewVal, NewLeft, NewRight}.

calculate_new_value({_Val, _, _} = Node, Level, ParentNode, LevelSums, ParentChildrenTotalSums) ->
    case ParentNode of
        nil -> % Root node has no cousins
            0;
        _ ->
            % Get the total sum of all nodes at the current level
            TotalSumAtLevel = maps:get(Level, LevelSums, 0),

            % Get the sum of all children of the ParentNode.
            % This sum includes the CurrentNode and all its siblings.
            SiblingsAndSelfSum = maps:get(ParentNode, ParentChildrenTotalSums, 0),

            % The sum of cousins for CurrentNode is:
            % (Total sum of all nodes at current Level) - (Sum of CurrentNode and its siblings)
            CousinsSum = TotalSumAtLevel - SiblingsAndSelfSum,
            CousinsSum
    end.