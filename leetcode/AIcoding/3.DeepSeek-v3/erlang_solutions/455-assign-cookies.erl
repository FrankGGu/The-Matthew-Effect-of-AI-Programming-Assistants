-spec find_content_children(G :: [integer()], S :: [integer()]) -> integer().
find_content_children(G, S) ->
    G1 = lists:sort(G),
    S1 = lists:sort(S),
    find_content_children(G1, S1, 0).

find_content_children([G | Gs], [S | Ss], Count) when S >= G ->
    find_content_children(Gs, Ss, Count + 1);
find_content_children(Gs, [_ | Ss], Count) ->
    find_content_children(Gs, Ss, Count);
find_content_children(_, _, Count) ->
    Count.