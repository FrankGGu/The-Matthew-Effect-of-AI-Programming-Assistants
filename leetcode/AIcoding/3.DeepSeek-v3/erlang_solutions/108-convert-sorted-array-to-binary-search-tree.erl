-spec sorted_array_to_bst(Nums :: [integer()]) -> TreeNode | nil.
sorted_array_to_bst(Nums) ->
    case Nums of
        [] -> nil;
        _ -> 
            {Left, [Mid | Right]} = lists:split(length(Nums) div 2, Nums),
            #{
                val => Mid,
                left => sorted_array_to_bst(Left),
                right => sorted_array_to_bst(Right)
            }
    end.