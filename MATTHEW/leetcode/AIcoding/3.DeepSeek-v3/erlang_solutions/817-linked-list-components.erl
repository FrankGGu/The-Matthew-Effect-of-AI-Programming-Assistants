-spec num_components(Head :: #list_node{} | null, G :: [integer()]) -> integer().
num_components(Head, G) ->
    GSet = sets:from_list(G),
    {Count, _} = traverse(Head, GSet, false, 0),
    Count.

traverse(null, _, _, Count) ->
    {Count, false};
traverse(#list_node{val = Val, next = Next}, GSet, InComponent, Count) ->
    IsInG = sets:is_element(Val, GSet),
    case {InComponent, IsInG} of
        {false, true} ->
            traverse(Next, GSet, true, Count + 1);
        {_, IsInG} ->
            traverse(Next, GSet, IsInG, Count)
    end.